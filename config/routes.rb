Trackinator::Application.routes.draw do
  devise_for :users

  root :to => 'victims#index'
  
  resources :victims
  resources :downloads, :only => [:show]
end
