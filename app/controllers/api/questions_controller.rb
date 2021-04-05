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
    result = QuestionConcept::Create.call(params: questions_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = QuestionConcept::Update.call(params: questions_params)
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

  def destroy
    result = QuestionConcept::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def destroy_all
    result = QuestionConcept::DestroyAll.call(params: params)
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

  def questions_params
    params.permit(:title, :answers, :image, :category_id, :id)
  end
end
