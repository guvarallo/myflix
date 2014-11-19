Myflix::Application.routes.draw do
  root 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/sign_in',  to: 'sessions#new'
  get '/register', to: 'users#new'
  get '/home',     to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]

end
