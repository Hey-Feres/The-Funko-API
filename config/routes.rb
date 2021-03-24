Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :features
      resources :items
      resources :brands
      resources :licenses
      resources :events
      resources :categories
    end
  end
end
