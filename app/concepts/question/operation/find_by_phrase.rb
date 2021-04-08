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
      options[:questions] = QuestionServices::FindByPhrase.new(category_id, phrase).call
    end

    def get_answers(options, phrase:, category_id:, **)
      options[:answers] = QuestionServices::FindInAnswersByPhrase.new(category_id, phrase).call
    end

    def get_answers_question(options, answers:, **)
      options[:answers_question] = answers.map(&:question)
    end

    def send_response(options, questions:, answers_question:, **)
      data = questions + answers_question
      options[:response] = QuestionsPresenters::Collection.new(data.uniq).call
    end
  end
end
