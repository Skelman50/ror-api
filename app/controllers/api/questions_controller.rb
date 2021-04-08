# frozen_string_literal: true

class Api::QuestionsController < ApplicationController
  def index
    result = Question::Operation::GetAll.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  def show
    result = Question::Operation::Show.call(params: params)
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end

  def create
    result = Question::Operation::Create.call(params: questions_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = Question::Operation::Update.call(params: questions_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def set_category
    result = Question::Operation::SetCategory.call(params: set_category_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def destroy
    result = Question::Operation::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def destroy_all
    result = Question::Operation::DestroyAll.call(params: params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def find_by_phrase
    result = Question::Operation::FindByPhrase.call(params: params)
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
