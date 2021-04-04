# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: %i[create index update destroy show] do
      delete :destroy_all, on: :collection
      get :find_by_phrase, on: :collection
    end

    resources :questions, only: %i[create index show update destroy] do
      delete :destroy_all, on: :collection
      put :set_category
    end
  end
end
