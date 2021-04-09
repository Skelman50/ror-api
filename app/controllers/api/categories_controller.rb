# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  before_action :authorized
  def index
    result = Category::Operation::GetAll.call
    render json: result[:categories] if result.success?
  end

  def create
    result = Category::Operation::Create.call(params: categories_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = Category::Operation::Update.call(params: categories_params, id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy
    result = Category::Operation::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy_all
    result = Category::Operation::DestroyAll.call
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def show
    result = Category::Operation::Show.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  def find_by_phrase
    result = Category::Operation::FindByPhrase.call(params: params)
    render json: { response: result[:response][:response] } if result.success?
  end

  private

  def categories_params
    params.require(:category).permit(:title, :is_active)
  end
end
