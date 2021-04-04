# frozen_string_literal: true

class Api::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    result = QuestionConcept::GetAll.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  def show
    result = QuestionConcept::Show.call(params: params)
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end

  def create
    result = QuestionConcept::Create.call(params: params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = QuestionConcept::Update.call(params: params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def set_category
    result = QuestionConcept::SetCategory.call(params: set_category_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  private

  def set_category_params
    params.permit(:question_id, :categoryId)
  end
end
