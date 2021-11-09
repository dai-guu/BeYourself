Rails.application.routes.draw do

  devise_for :users
  root to:'posts#index'


  resources :post_images
  
  resources :users, only: [:show,:edit,:update,:unsubscribe,:withdraw]
end
