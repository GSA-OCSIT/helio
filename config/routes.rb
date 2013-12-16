Helio::Application.routes.draw do
  ActiveAdmin.routes(self)
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update]
  resources :subscriptions, :only => [:index, :new, :create]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
end
