Rails.application.routes.draw do
  resources :features
  resources :items
  resources :brands
  resources :licenses
  resources :events
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
