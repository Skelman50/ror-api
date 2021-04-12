# frozen_string_literal: true

module Question::Operation
  class Show < ApplicationOperation
    step :find_question

    def find_question(options, params:, **)
      question = Question.find(params[:id])
      unless question
        options[:error] = { message: 'Запитання не знайдено', status: 400 }
        return false
      end
      options[:response] = QuestionsPresenters::Item.new(question, true).call
    end
  end
end
