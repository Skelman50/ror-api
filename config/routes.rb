# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get '/categories', to: 'categories#index'
    post '/categories/create', to: 'categories#create'
    put '/categories/:id', to: 'categories#update'
    delete '/categories/:id', to: 'categories#destroy_by_id'
    delete '/categories', to: 'categories#destroy_all'
  end
end
