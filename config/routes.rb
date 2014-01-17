Nytech::Application.routes.draw do
  resources :users
  resources :jobs do 
    collection { post :import }
  end
  resource :session, only: [:new, :create, :destroy]
  resources :searches, only: [:new, :show, :create, :destroy]
  
  match '/home',    to: 'static_pages#home', via: :get
  match '/signup',  to: 'users#new', via: :get
  match '/logout',  to: 'sessions#destroy', via: :delete
  match '/login',   to: 'sessions#new', via: :get
   
  root to: 'static_pages#home'
end
