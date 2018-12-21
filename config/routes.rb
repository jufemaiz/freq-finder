# frozen_string_literal: true

Rails.application.routes.draw do
  post '/v2', to: 'graphql#execute'

  namespace :v1 do
    jsonapi_resources :stations
    jsonapi_resources :transmitters
  end

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  resources :stations do
    resources :transmitters, only: [:index]
  end

  resources :transmitters
end
