# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: CategoriesServices::GetAll.new.call
  end

  def create
    response = CategoriesServices::Create.new(categories_params).call
    if response[:success]
      head :ok
    else
      render json: response, status: 400
    end
  end

  def update
    category = Category.find(params[:id])
    category.update(categories_params)
    head :ok
  end

  def destroy_by_id
    category = Category.find(params[:id])
    if category.destroy
      head :ok
    else
      render json: { message: 'Categoy not found' }, status: 404
    end
  end

  def destroy_all
    Category.destroy_all
    head :ok
  end

  private

  def categories_params
    params.permit(:title, :is_active)
  end
end
