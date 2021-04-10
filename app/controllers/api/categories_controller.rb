# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  before_action :authorized, except: [:default]
  def index
    result = Category::Operation::GetAll.call
    generate_response(result)
  end

  def create
    result = Category::Operation::Create.call(params: categories_params)
    generate_response(result)
  end

  def update
    result = Category::Operation::Update.call(params: categories_params, id: params[:id])
    generate_response(result)
  end

  def destroy
    result = Category::Operation::Destroy.call(id: params[:id])
    generate_response(result)
  end

  def destroy_all
    result = Category::Operation::DestroyAll.call
    generate_response(result)
  end

  def show
    result = Category::Operation::Show.call(params: params)
    generate_response(result)
  end

  def find_by_phrase
    result = Category::Operation::FindByPhrase.call(params: params)
    generate_response(result)
  end

  def default
    result = Category::Operation::Default.call
    generate_response(result)
  end

  private

  def categories_params
    params.require(:category).permit(:title, :is_active)
  end
end
