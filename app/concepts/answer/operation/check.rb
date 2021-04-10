# frozen_string_literal: true

module Answer::Operation
  class Check < ApplicationOperation
    step :get_answer

    def get_answer(options, params:, **)
      answer = Answer.find(params[:answer_id])

      if answer
        options[:response] = answer
      else
        options[:error] = { message: 'Answer not found', status: 404 }
      end
    end
  end
end
