Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root "feed#show"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  resource :profile, only: [ :show, :update ], controller: "users"

  resources :listings, except: :index
  resource :my_listings, only: :show

  namespace :users do
    patch "change_password", to: "passwords#update"
    resources :password_resets, only: [ :new, :create, :edit, :update ]
  end
end
