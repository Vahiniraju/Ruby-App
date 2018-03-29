Rails.application.routes.draw do
  get 'questions/new'

  root 'welcome#index'
  get '/index', to: 'welcome#index'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: "sessions#destroy"
  get '/question', to: "questions#new"
  post '/question', to: "questions#create"
  resources :users do
    member do
      get :deactivate
    end
  end
  resources :questions


end
