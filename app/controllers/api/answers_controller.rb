# frozen_string_literal: true

class Api::AnswersController < ApplicationController
  def check
    result = Answer::Operation::Check.call(params: params)
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end
end
