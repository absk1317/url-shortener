# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'url#index'
  resources :url, only: :create
  get '/urls/:short', to: 'url#show'
  namespace :api do
    resources :url, only: [:create, :index, :destroy]
    post '/bulk_upload', to: 'url#bulk_upload'
  end
end
