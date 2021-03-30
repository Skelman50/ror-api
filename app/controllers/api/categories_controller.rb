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
    response = CategoriesServices::Update.new(categories_params, params[:id]).call
    if response[:success]
      head :ok
    else
      render json: response, status: 404
    end
  end

  def destroy_by_id
    response = CategoriesServices::DestroyById.new(params).call
    if response[:success]
      head :ok
    else
      render json: response, status: 404
    end
  end

  def destroy_all
    CategoriesServices::DestroyAll.new.call
    head :ok
  end

  private

  def categories_params
    params.permit(:title, :is_active)
  end
end
