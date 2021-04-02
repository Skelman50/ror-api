# frozen_string_literal: true

class Api::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    result = QuestionConcept::Create.call(params: params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end
end
