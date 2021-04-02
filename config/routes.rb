# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: %i[create index update destroy show] do
      delete '/', to: 'categories#destroy_all', on: :collection
    end

    resources :questions, only: %i[create] do
    end
  end
end
