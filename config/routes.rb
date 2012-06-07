Giftmenow::Application.routes.draw do
 
  devise_for :users
  
  get "home/index" 
  
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/:provider' => 'authentications#passthru'
  
  root :to => 'home#index'
   
end
