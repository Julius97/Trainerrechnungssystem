Rails.application.routes.draw do

  root "dashboard#index"

  #SESSION ROUTES
  resources :session
  get "login", to: "session#index", :as => "login"
  post "login", to: "session#create"
  get "logout", to: "session#destroy", :as => "logout"

  #USER ROUTES
  resources :user
  get "/user/:id/:acc_period_id", to: "user#show", :as => "user_with_acc_period"
  get "register", to: "user#new", :as => "register"
  post "register", to: "user#create"

  #DASHBOARD ROUTES
  resources :dashboard
  get "date_status", to: "dashboard#date_status"
  get "time_status", to: "dashboard#time_status"

  #CUSTOMER ROUTES
  resources :customer

  #GROUP ROUTES
  resources :group
  get "/group/:id/:acc_period_id", to: "group#show", :as => "group_with_acc_period"
  post "add_customer_to_group", to: "group#add_customer_to_group"

  #ACCOUNTING GROUP ROUTES
  resources :accounting_group

  #ACCOUNTING PERIOD ROUTES
  resources :accounting_period

  #GROUPCLASSIFICATION ROUTES
  resources :groupclassification

  #TRAINING ROUTES
  resources :training
  get "destroy_whole_training/:start_time/:end_time/:group_id", to: "training#destroy_whole_training", :as => "destroy_whole_training"

  #ADDITIONAL TRAINING ROUTES
  resources :additional_training

  #PRICE ROUTES
  resources :price

  #CONTACT ROUTES
  get "contact", to: "contact#new"
  post "contact", to: "contact#create"

  #SETTINGS ROUTES
  get "settings", to: "settings#index"

  #TRAININGSPLAN ROUTES
  resources :trainingsplan
  post "clean_trainingsplan_before_update", to: "trainingsplan#clean_trainingsplan_before_update"

  #ACCOUNT INFORMATION ROUTES
  resources :account_information

  # STATIC PAGES
  static_pages = [:imprint]
  static_pages.each { |static_page| get static_page.to_s, to: "static#" + static_page.to_s, as: ("static_" + static_page.to_s).intern }

end