Myflix::Application.routes.draw do
  root 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get  '/sign_in',      to: 'sessions#new'
  post '/sign_in',      to: 'sessions#create'
  get  '/sign_out',     to: 'sessions#destroy'
  get  '/register',     to: 'users#new'
  get  '/home',         to: 'videos#index'
  get  '/queue',        to: 'queue_items#index'
  post '/update_queue', to: 'queue_items#update_queue'
  get  '/people',       to: 'relationships#index'

  resources :users,         only: [:create, :show]
  resources :categories,    only: [:show]
  resources :queue_items,   only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
end
