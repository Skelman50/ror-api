# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: %i[create index update destroy show] do
      delete '/', to: 'categories#destroy_all', on: :collection
    end

    resources :questions, only: %i[create index] do
      put :set_category
    end
  end
end
