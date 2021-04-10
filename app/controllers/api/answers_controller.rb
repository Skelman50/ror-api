# frozen_string_literal: true

class Api::AnswersController < ApplicationController
  def check
    result = Answer::Operation::Check.call(params: params)
    generate_response(result)
  end
end
