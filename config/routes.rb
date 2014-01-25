Nytech::Application.routes.draw do
  get "companies/create"
  get "companies/destroy"
  get "companies/edit"
  get "companies/update"
  get "companies/index"
  resources :users
  resources :searches, only: [:new, :show, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :jobs do 
    collection { post :import }
    member { get :root_action}
  end
    
  match '/home',    to: 'static_pages#home', via: :get
  match '/signup',  to: 'users#new', via: :get
  match '/logout',  to: 'sessions#destroy', via: :delete
  match '/login',   to: 'sessions#new', via: :get
   
  root to: 'jobs#root_action'
end
