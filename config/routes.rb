Rails.application.routes.draw do
  devise_for :users,
  controllers: { 
    registrations: "registrations",
    sessions: "sessions",
  }
  root "top#index"

  resources :users, only: [:index,:show]

  resources :reactions , only: [:create]

  resources :matching , only: [:index]

  resources :chat_rooms, only: [:create,:show] do
    member do
      get "show_additionally"
    end
  end

end
