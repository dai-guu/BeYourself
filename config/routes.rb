Rails.application.routes.draw do

  devise_for :users
  root to:'homes#top'
  get 'about' => 'homes#about'

  resources :users, only: [:show,:edit,:update,:unsubscribe,:withdraw] do
   resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :post_images do
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

    get '/post_image/hashtag/:name' => 'post_images#hashtag'
    get '/post_image/hashtag' => 'post_images#hashtag'

end