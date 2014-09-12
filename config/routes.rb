Rails.application.routes.draw do

  root 'pages#start'

  resources :users, only: [:create] do
    resources :apps
  end

  get '/pages/index', to: 'pages#index' #as: 'pages_index'
  get '/pages/myapps', to: 'pages#myapps'
  get '/pages/resources', to: 'pages#resources'
  get '/pages/createapp', to: 'pages#createapp'
  get '/pages/location', to: 'pages#location'
  get '/pages/apps', to: 'pages#viewapps'
  get '/pages/developer', to: 'pages#developer'
  get '/pages/myaccount', to: 'pages#myacount'

  match '/signup', to: "users#new", :as => "signup", via: :get
  match '/signout', to: "sessions#destroy", :as => "signout", via: :get
  match '/signin', to: "sessions#new", :as => "signin", via: :get
  
  match '/session/sensor', to: "sessions#sensor", as: 'buildsensor', via: :post
  match '/session/actuator', to: "sessions#actuator", as: 'buildactuator', via: :post
  match '/app/confirm', to: "apps#confirm", as: 'app_confirm', via: :get

  match '/app/build', to: 'apps#create', as: 'app_build', via: :post

  get 'query/sensors', to: 'sensors#queryAll'
  get 'query/actuators', to: 'actuators#queryAll'
  
  get 'query/user/:user_id/app/:app_id', to: 'apps#query'
  get 'query/user/:user_id/apps', to: 'users#queryApps'

  resources :actuators
	match 'user/actuators', to: 'actuators#create', :as=>'user_actuators', via: :post
  resources :sensors
	match 'user/sensors', to: "sensors#create",:as => 'user_sensors', via: :post
  resources :sessions, only: [:new, :create, :destroy] 

end
