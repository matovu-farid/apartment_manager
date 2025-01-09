# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  resources :expenditures
  resources(:rent_sessions)
  resources(:blocks)
  resources(:apartments)
  resources(:residents) do
    get("setup_payment", to: "residents#setup_payment", as: :setup_resident_payment)
    post("add_payment", to: "residents#add_payment", as: :add_resident_payment)
    resources(:payments)
  end

  resources(:payments) do
    get("receipt", to: "payments#receipt", as: :receipt)
  end


  get("residentsarchives", to: "residents#archives", as: :archives)
  get("create_rent_sessions", to: "residents#create_rent_sessions", as: :create_rent_sessions)
  get("home/index")
  post("block/pull", to: "blocks#pull", as: "block_pull")
  get("rent_session/renew", to: "rent_sessions#renew_rent", as: "renew_rent")
  devise_for(:users)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  authenticated(:user) do
    root(to: "apartments#index", as: :authenticated_root)
  end
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  root(to: redirect("/users/sign_in"))
  # Defines the root path route ("/")
  # root "articles#index"
end
