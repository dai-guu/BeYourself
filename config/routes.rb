Rails.application.routes.draw do

  devise_for :users
  root to:'homes#top'

  resources :users, only: [:show,:edit,:update,:unsubscribe,:withdraw] do
   resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :post_images do
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end



end