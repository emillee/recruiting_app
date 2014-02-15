Nytech::Application.routes.draw do
  resources :search_suggestions

  resources :users
  resources :searches, only: [:new, :show, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :taxonomies, only: [:index]
  resources :companies do
    resources :jobs, only: [:create]
  end

  resources :jobs, only: [:show, :index, :new, :update, :destroy] do 
    collection { post :import }
    member { get :root_action }
    member { post :get_input }
    member { put :update_key_skills }
  end
  
  namespace :admin do 
    resources :jobs, :companies, only: [:index, :new]
  end
    
  match '/home',    to: 'static_pages#home', via: :get
  match '/signup',  to: 'users#new', via: :get
  match '/logout',  to: 'sessions#destroy', via: :delete
  match '/login',   to: 'sessions#new', via: :get
  match '/filters', to: 'jobs#filters', via: :get
  
  match '/auth/:provider/callback', to: 'session#create', via: :get
   
  root to: 'jobs#root_action'
end
