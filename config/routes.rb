Rails.application.routes.draw do
  resources :payments
  resources :rent_sessions
  resources :blocks
  resources :apartments
  resources :residents

  get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  # Defines the root path route ("/")
  # root "articles#index"
end
