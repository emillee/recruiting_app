Nytech::Application.routes.draw do
  resources :users
  resources :searches, only: [:new, :show, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :companies

  resources :jobs, only: [:show, :index, :new, :creates] do 
    collection { post :import }
    member { get :root_action}
  end
  
  namespace :admin do 
    resources :jobs, :companies
  end
    
  match '/home',    to: 'static_pages#home', via: :get
  match '/signup',  to: 'users#new', via: :get
  match '/logout',  to: 'sessions#destroy', via: :delete
  match '/login',   to: 'sessions#new', via: :get
   
  root to: 'jobs#root_action'
end
