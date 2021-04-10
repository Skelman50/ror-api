# frozen_string_literal: true

class Api::QuestionsController < ApplicationController
  before_action :authorized, except: [:game]
  def index
    result = Question::Operation::GetAll.call(params: params)
    generate_response(result)
  end

  def show
    result = Question::Operation::Show.call(params: params)
    generate_response(result)
  end

  def create
    result = Question::Operation::Create.call(params: questions_params)
    generate_response(result)
  end

  def update
    result = Question::Operation::Update.call(params: questions_params)
    generate_response(result)
  end

  def set_category
    result = Question::Operation::SetCategory.call(params: set_category_params)
    generate_response(result)
  end

  def destroy
    result = Question::Operation::Destroy.call(id: params[:id])
    generate_response(result)
  end

  def destroy_all
    result = Question::Operation::DestroyAll.call(params: params)
    generate_response(result)
  end

  def find_by_phrase
    result = Question::Operation::FindByPhrase.call(params: params)
    generate_response(result)
  end

  def game
    result = Question::Operation::Game.call(params: params)
    generate_response(result)
  end

  private

  def set_category_params
    params.permit(:question_id, :categoryId)
  end

  def questions_params
    params.permit(:title, :answers, :image, :category_id, :id)
  end
end
