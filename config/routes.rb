Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/timetable", to: "user_courses#index"
  get "/chatroom", to: "messages#index"
  root "static_pages#home"

  resources :users

  resources :posts do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :conversations, only: [:create] do
    resources :messages, only: [:create]

    member do
      post :close
    end
  end
end
