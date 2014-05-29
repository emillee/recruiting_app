Nytech::Application.routes.draw do

  # routes for joins tables
  resource  :user_jobs, only: [:create, :destroy]
  resources :object_skills, only: [:create, :update, :destroy] 
  resources :user_articles, only: [:create, :destroy]
  resources :taggings, only: [:create, :destroy]
  resources :user_articles, only: [:create, :destroy]
  
  # models that don't have views
  resources :tags, only: [:index, :create, :destroy]  
  resources :taxonomies, only: [:index]
  resources :images, only: [:create, :destroy] do 
    member { post :remove }
  end
  
  # models in progress
  resources :groups
  resources :chatrooms, only: [:index, :create, :destroy, :show]
  resources :messages, only: [:create, :destroy]

  # models with views
  resource  :session, only: [:new, :create, :destroy]
  resources :articles, only: [:index, :create, :destroy]
  resources :skills, only: [:index, :create, :update, :destroy] do
    collection { get :name }
    collection { get :dept }
    collection { get :sub_dept }
  end

  resources :users do 
    resources :articles, only: [:create, :update]
    member { post :delete_snapshot }
  end  

  resources :investors do
    resources :articles, only: [:create, :update]
    member { post :delete_snapshot }
  end    

  resources :companies, only: [:index, :new, :update, :show, :destroy] do
    member { get :next }
    member { put :add_section }
    member { post :delete_snapshot }
    collection { get :autocomplete_fields }
    resources :jobs, only: [:create]
    resources :articles, only: [:create, :update]
  end

  resources :jobs, only: [:show, :index, :new, :update, :destroy, :edit] do 
    member { get :edit_company }
    member { post :import_data }
    member { put :update_req_skills }
    member { get :forward_form }
    collection { get :flip_view }
  end
  
  namespace :admin do 
    resources :jobs, :companies, only: [:index, :show, :new]
  end
  
  # authentication
  match '/signup',                   to: 'users#new', via: :get
  match '/logout',                   to: 'sessions#destroy', via: :delete
  match '/login',                    to: 'sessions#new', via: :get
  match '/auth/:provider/callback',  to: 'sessions#create', via: [:get, :post]

  # mailers
  match '/forward_job',              to: 'jobs#forward_job', via: :post
  match '/contact_us',               to: 'shared#contact_us', via: :get
  match '/send_contact_us_email',    to: 'shared#send_contact_us_email', via: :post

  match '/all_activity',             to: 'shared#all_activity', via: :get

  root to: 'jobs#index'
end