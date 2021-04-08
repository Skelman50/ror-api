# frozen_string_literal: true

module QuestionServices
  class FindInAnswersByPhrase
    attr_reader :category_id, :phrase

    def initialize(category_id, phrase)
      @category_id = category_id
      @phrase = phrase
    end

    def call
      if @category_id
        Answer.joins(find_in_answers_join_query)
              .where(where_query_with_category, @category_id, "%#{@phrase}%", "%#{@phrase}%", "%#{@phrase}%")
      else
        Answer.joins(find_in_answers_join_query)
              .where(where_query_without_category, "%#{@phrase}%", "%#{@phrase}%", "%#{@phrase}%")
      end
    end

    private

    def find_in_answers_join_query
      'INNER JOIN questions on questions.id = question_id'
    end

    def where_query_with_category
      'questions.category_id = ? AND (answers.title ILIKE ? OR answers."displayMessage" ILIKE ? OR answers.description ILIKE ?)'
    end

    def where_query_without_category
      'answers.title ILIKE ? OR answers."displayMessage" ILIKE ? OR answers.description ILIKE ?'
    end
  end
end
