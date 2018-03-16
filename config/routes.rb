Rails.application.routes.draw do
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'sessions#top'

  resources :contacts do
    collection do
    get :top
  end
  end

  resources :likes, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :posts do
    resources :comments
    collection do
    post :confirm
    end
  end
end
