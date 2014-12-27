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

  resources :users,       only: [:create]
  resources :categories,  only: [:show]
  resources :queue_items, only: [:create, :destroy]

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

end
