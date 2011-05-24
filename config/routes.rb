Trackinator::Application.routes.draw do
  root :to => 'victims#index'
  
  resources :victims
end
