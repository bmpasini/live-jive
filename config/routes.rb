Rails.application.routes.draw do

  # root
  root 'static_pages#home'

  # signups
  get 'users/new'  => 'users#new', as: :user_signup
  post 'users'  => 'users#create'
  get 'bands/new'  => 'bands#new', as: :band_signup
  post 'bands'  => 'bands#create'

  # sessions
  get 'user_login' => 'sessions#user_login', as: :user_login
  post 'user_login' => 'sessions#user_create'
  get 'band_login' => 'sessions#band_login', as: :band_login
  post 'band_login' => 'sessions#band_create'
  delete 'logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]

  # password reset
  resources :user_password_resets, only: [:new, :create, :edit, :update]
  resources :band_password_resets, only: [:new, :create, :edit, :update]

  # main pages
  resources :concert_lists
  resources :concerts
  resources :bands, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :fans
    end
    collection do
      get :sorted_by_genre
    end
  end
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :following, :followers, :favorite_bands, :concerts
      get :concert_lists
      get :feed
    end
  end
  resources :user_relationships, only: [:create, :destroy]
  resources :fanships, only: [:create, :destroy]
  resources :concert_goings, only: [:create, :edit, :update, :destroy]
  resources :genres

  # static pages
  get  'home' => 'static_pages#home'
  get  'help' => 'static_pages#help'
  get  'about' => 'static_pages#about'
  get  'contact' => 'static_pages#contact'

end
