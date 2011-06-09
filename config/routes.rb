Trackinator::Application.routes.draw do
  devise_for :users

  root :to => 'victims#index'

  resources :victims do
    resources :visits do
      collection do
        delete :index
      end
    end
  end
  
  # match 'victims/:victim_id/visits' => 'visits#index', :via => [:get, :post, :delete]
  
  
  resources :downloads, :only => [:show]
end
