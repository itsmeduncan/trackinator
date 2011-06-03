Trackinator::Application.routes.draw do
  root :to => 'victims#index'
  
  resources :victims, :only => [:index, :show]
  resources :downloads, :only => [:show]
end
