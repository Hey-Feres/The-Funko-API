Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :features, only: %i[index show]
      resources :items, only: %i[index show]
      resources :brands, only: %i[index show]
      resources :licenses, only: %i[index show]
      resources :events, only: %i[index show]
      resources :categories, only: %i[index show]
      resources :collections
      resources :wish_lists
      post      :search, to: 'searches#index'
    end
  end
end
