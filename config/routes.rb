Nytech::Application.routes.draw do
  resource :user_jobs, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :search_suggestions
  resources :searches, only: [:new, :show, :create, :destroy]
  resources :taxonomies, only: [:index]
  resources :object_skills, only: [:create, :update, :destroy] 
  resources :tags, only: [:index, :create, :destroy]
  resources :taggings, only: [:create, :destroy]
  resources :articles, only: [:create, :destroy]
  resources :user_articles, only: [:create, :destroy]
  resources :groups

  resources :chat
  
  # resources :chats, only: [:index, :create, :destroy, :show] do 
  #   collection { get :events }
  # end

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
  
  resources :jobs, only: [:show, :index, :new, :update, :destroy] do 
    member { post :import_data }
    member { put :update_req_skills }
    member { get :forward_form }
    collection { get :flip_view }
  end
  
  namespace :admin do 
    resources :jobs, :companies, only: [:index, :new]
  end
    
  match '/home',                     to: 'static_pages#home', via: :get
  match '/signup',                   to: 'users#new', via: :get
  match '/logout',                   to: 'sessions#destroy', via: :delete
  match '/login',                    to: 'sessions#new', via: :get
  match '/filters',                  to: 'jobs#filters', via: :get
  match '/forward_job',              to: 'jobs#forward_job', via: :post
  
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
   
  root to: 'jobs#root_action'
end

# ARCHIVE
# resources :jobs, only: [:show, :index, :new, :update, :destroy] do 
#   collection { post :import }
#   member { get :root_action }
# end