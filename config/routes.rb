# frozen_string_literal: true

Freqfinder::Application.routes.draw do
  resources :transmitters
  resources :stations

  get 'results' => 'search#results', as: :search_results
  get 'geolocate' => 'search#geolocate', as: :geolocate
  root to: 'search#index'
end
