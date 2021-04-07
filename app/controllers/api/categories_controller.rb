# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    result = Category::GetAll.call
    render json: result[:categories] if result.success?
  end

  def create
    result = Category::Create.call(params: categories_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = Category::Update.call(params: categories_params, id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy
    result = Category::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy_all
    result = Category::DestroyAll.call
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def show
    result = Category::Show.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  def find_by_phrase
    result = Category::FindByPhrase.call(params: params)
    render json: { response: result[:response][:response] } if result.success?
  end

  private

  def categories_params
    params.require(:category).permit(:title, :is_active)
  end
end
