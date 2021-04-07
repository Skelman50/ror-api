# frozen_string_literal: true

class Api::QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    result = Question::GetAll.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  def show
    result = Question::Show.call(params: params)
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end

  def create
    result = Question::Create.call(params: questions_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = Question::Update.call(params: questions_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def set_category
    result = Question::SetCategory.call(params: set_category_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def destroy
    result = Question::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def destroy_all
    result = Question::DestroyAll.call(params: params)
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
