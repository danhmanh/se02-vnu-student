Rails.application.routes.draw do
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root "posts#index"
  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end
end
