Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',

  }
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  root to: 'homes#top'
  get 'about' => 'homes#about'

  resources :users, only: [:show, :edit, :update, :unsubscribe, :hide, :withdraw] do
    resource :relationships, only: [:create, :destroy]

    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

    get 'users/unsubscribe'
    patch 'users/update'
    patch 'users/withdraw'
  end

  resources :post_images do
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get '/post_image/hashtag/:name' => 'post_images#hashtag'
  get '/post_image/hashtag' => 'post_images#hashtag'

  get 'post_images/category/all' => 'post_images#all'
  get 'post_images/category/men' => 'post_images#men'
  get 'post_images/category/women' => 'post_images#women'
  get 'post_images/category/kids' => 'post_images#kids'
  get 'post_images/category/business' => 'post_images#business'

  get 'search' => 'post_images#search'
end
