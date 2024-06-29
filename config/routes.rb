Rails.application.routes.draw do
  resources(:rent_sessions) do
    resources(:payments)
  end

  resources(:blocks)
  resources(:apartments)
  resources(:residents)

  get("home/index")
  post("block/pull", to: "blocks#pull", as: "block_pull")
  get("rent_session/renew", to: "rent_sessions#renew_rent", as: "renew_rent")
  devise_for(:users)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  authenticated(:user) do
    root(to: "apartments#index", as: :authenticated_root)
  end

  root(to: redirect("/users/sign_in"))
  # Defines the root path route ("/")
  # root "articles#index"
end
