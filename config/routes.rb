Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  match '/auth/login', :to => 'authentication#login', :via => :post
  match '/*a', :to => 'application#not_found', :via => :get
  
  resources :facts
end
