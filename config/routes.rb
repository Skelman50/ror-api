# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: %i[create index update destroy show] do
      delete :destroy_all, on: :collection
      get :find_by_phrase, on: :collection
      get :default, on: :collection
    end

    resources :questions, only: %i[create index show update destroy] do
      delete :destroy_all, on: :collection
      put :set_category
      get :find_by_phrase, on: :collection
      get '/:category_id/game', to: 'questions#game', on: :collection
    end

    resources :users, only: [] do
      post :login, on: :collection
      get :auto_login, on: :collection
    end

    resources :answers, only: [] do
      get :check
    end
  end
end
