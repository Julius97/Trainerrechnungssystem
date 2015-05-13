Rails.application.routes.draw do

  root "dashboard#index"

  #SESSION ROUTES
  resources :session
  get "login", to: "session#index", :as => "login"
  post "login", to: "session#create"
  get "logout", to: "session#destroy", :as => "logout"

  #USER ROUTES
  resources :user
  get "register", to: "user#new", :as => "register"
  post "register", to: "user#create"

  #DASHBOARD ROUTES
  resources :dashboard

  #CUSTOMER ROUTES
  resources :customer

  #GROUP ROUTES
  resources :group
  post "add_customer_to_group", to: "group#add_customer_to_group"

  #GROUPCLASSIFICATION ROUTES
  resources :groupclassification

  #TRAINING ROUTES
  resources :training

end