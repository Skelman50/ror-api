# frozen_string_literal: true

module QuestionServices
  class FindByPhrase
    attr_reader :category_id, :phrase

    def initialize(category_id, phrase)
      @category_id = category_id
      @phrase = phrase
    end

    def call
      if @category_id
        Question.where('title ILIKE ? and category_id = ?', "%#{@phrase}%", @category_id)
      else
        Question.where('title ILIKE ?', "%#{@phrase}%")
      end
    end

  end
end