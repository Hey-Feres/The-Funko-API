Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :items, only: %i[index show]

      resources :features, only: %i[index show] do
        get '/items', to: 'features#items'
      end

      resources :brands, only: %i[index show] do
        get '/items', to: 'brands#items'
      end

      resources :licenses, only: %i[index show] do
        get '/items', to: 'licenses#items'
      end

      resources :events, only: %i[index show] do
        get '/items', to: 'events#items'
      end

      resources :categories, only: %i[index show] do
        get '/items', to: 'categories#items'
      end

      resources :collections
      resources :wish_lists

      post      :search, to: 'searches#index'
    end
  end
end
