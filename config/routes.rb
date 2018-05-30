# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'url#index'
  resources :url, only: :create
  get '/urls/:short', to: 'url#show'
end
