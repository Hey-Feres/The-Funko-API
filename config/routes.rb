Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :features, only: %i[index show]
      resources :items, only: %i[index show]
      resources :brands, only: %i[index show]
      resources :licenses, only: %i[index show]
      resources :events, only: %i[index show]
      resources :categories, only: %i[index show]
      resources :collections
      post      :search, to: 'searches#index'
    end
  end
end
