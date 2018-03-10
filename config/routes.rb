Rails.application.routes.draw do
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :contacts

  root to: 'sessions#new'
  resources :likes, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :posts do
    collection do
    post :confirm
    get :top
    end
  end
end
