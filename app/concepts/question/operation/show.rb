# frozen_string_literal: true

module Question::Operation
  class Show < ApplicationOperation
    step :find_question

    def find_question(options, params:, **)
      question = Question.find(params[:id])
      if question
        options[:response] = QuestionsPresenters::Item.new(question, true).call
      else
        options[:error] = { message: 'Запитання не знайдено', status: 400 }
        false
      end
    end
  end
end
