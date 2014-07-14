Nytech::Application.routes.draw do

  # routes for joins tables
  resource  :user_jobs, only: [:create, :destroy]
  resources :object_skills, only: [:create, :update, :destroy] 
  resources :user_articles, only: [:create, :destroy]
  resources :taggings, only: [:create, :destroy]
  resources :user_articles, only: [:create, :destroy]
  resources :user_job_preapprovals, only: [:create, :destroy]
  
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
  resources :articles do 
    member { put :increase_views }
    member { put :increase_recs }
    resources :comments, only: [:create]
  end
  resource  :session, only: [:new, :create, :destroy]
  resources :skills, only: [:index, :create, :update, :destroy] do
    collection { get :name }
    collection { get :dept }
    collection { get :sub_dept }
  end

  resources :users do 
    member { post :delete_snapshot }
    resources :articles, only: [:create, :update, :new, :index, :edit]
  end  

  resources :investors do
    member { post :delete_snapshot }
  end    

  resources :companies, only: [:index, :new, :update, :show, :destroy] do
    member { put :add_section }
    member { post :delete_snapshot }
    collection { get :autocomplete_fields }
    resources :jobs, only: [:create]
    resources :articles, only: [:create, :update, :new, :index]
  end

  resources :jobs, only: [:show, :index, :new, :update, :destroy, :edit] do 
    member { get :wolfpack_option }
    member { get :edit_company }
    member { post :import_data }
    member { put :update_req_skills }
    member { get :forward_form }
    collection { get :flip_view }
  end
  
  namespace :admin do 
    resources :jobs, :companies, only: [:index, :show, :new] do 
      collection { get :send_listings_form }
      collection { get :preapproval_applicants }
    end
    resources :prospects, only: [:index] do 
      collection { post :create_from_link }
    end
    resources :users, only: [:edit, :update]
    resources :skills, only: [:index, :create, :destroy]
  end
  
  # authentication
  match '/signup',                   to: 'users#new', via: :get
  match '/login',                    to: 'sessions#new', via: :get
  match '/logout',                   to: 'sessions#destroy', via: :delete
  match '/auth/:provider/callback',  to: 'sessions#create', via: [:get, :post]

  # mailers
  match '/send_listings',            to: 'admin/jobs#send_listings', via: :post
  match '/forward_job',              to: 'jobs#forward_job', via: :post
  match '/contact_us',               to: 'shared#contact_us', via: :get
  match '/send_contact_us_email',    to: 'shared#send_contact_us_email', via: :post

  match '/all_activity',             to: 'shared#all_activity', via: :get
  match '/welcome_to_wolfpack',      to: 'shared#welcome_to_wolfpack', via: :get
  match '/pending_applicant',        to: 'shared#pending_applicant', via: :get

  match '/',                         to: 'articles#index', constraints: { subdomain: /blog/ }, via: :get
  root to: 'jobs#index'
end