# frozen_string_literal: true

module Question::Operation
  class FindByPhrase < ApplicationOperation
    pass :get_phrase
    pass :get_cagory_id
    pass :get_questions
    step :get_answers
    step :get_answers_question
    step :send_response

    def get_phrase(options, params:, **)
      options[:phrase] = params[:phrase]
    end

    def get_cagory_id(options, params:, **)
      options[:category_id] = if params[:id].present?
                                params[:id]
                              else
                                false
                              end
    end

    def get_questions(options, category_id:, phrase:, **)
      options[:questions] = if category_id
                              Question.where('title ILIKE ? and category_id = ?', "%#{phrase}%", category_id)
                            else
                              Question.where('title ILIKE ?', "%#{phrase}%")
                            end
    end

    def get_answers(options, phrase:, category_id:, **)
      options[:answers] = find_in_answers_where_query(category_id, phrase)
    end

    def get_answers_question(options, answers:, **)
      options[:answers_question] = answers.map(&:question)
    end

    def send_response(options, questions:, answers_question:, **)
      data = questions + answers_question
      options[:response] = QuestionsPresenters::Collection.new(data.uniq).call
    end

    private

    def find_in_answers_join_query
      'INNER JOIN questions on questions.id = question_id'
    end

    def find_in_answers_where_query(category_id, phrase)
      if category_id
        query = 'questions.category_id = ? AND (answers.title ILIKE ? OR answers."displayMessage" ILIKE ? OR answers.description ILIKE ?)'
        Answer.joins(find_in_answers_join_query)
              .where(query, category_id, "%#{phrase}%", "%#{phrase}%", "%#{phrase}%")
      else
        query = 'answers.title ILIKE ? OR answers."displayMessage" ILIKE ? OR answers.description ILIKE ?'
        Answer.joins(find_in_answers_join_query)
              .where(query, "%#{phrase}%", "%#{phrase}%", "%#{phrase}%")
      end
    end
  end
end
