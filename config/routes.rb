Trackinator::Application.routes.draw do
  root :to => 'victims#index'
  
  resources :victims
  resources :downloads, :only => [:show]
end
