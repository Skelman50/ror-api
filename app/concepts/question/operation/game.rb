# frozen_string_literal: true

module Question::Operation
  class Game < ApplicationOperation
    step :find_questions
    step :generate_response

    def find_questions(options, params:, **)
      options[:questions] = Question.where(category_id: params[:category_id])
    end

    def generate_response(options, questions:, **)
      options[:response] = QuestionsGamePresenters::Collection.new(questions).call
    end
  end
end
