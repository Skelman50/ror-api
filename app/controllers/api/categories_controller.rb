# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    result = CategoryConcept::GetAll.call
    render json: result[:categories] if result.success?
  end

  def create
    result = CategoryConcept::Create.call(params: categories_params)
    if result.success?
      head :ok
    else
      error_handler(result)
    end
  end

  def update
    result = CategoryConcept::Update.call(params: categories_params, id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy
    result = CategoryConcept::Destroy.call(id: params[:id])
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def destroy_all
    result = CategoryConcept::DestroyAll.call
    if result.success?
      head :ok
    else
      render json: result[:error], status: 404
    end
  end

  def show
    result = CategoryConcept::Show.call(params: params)
    render json: { response: result[:response] } if result.success?
  end

  private

  def categories_params
    params.permit(:title, :is_active)
  end
end
