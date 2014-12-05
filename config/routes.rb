Rails.application.routes.draw do

  # root
  root 'sessions#user_login'

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
  
  # main pages
  resources :concert_lists
  resources :concerts
  resources :bands, only: [:index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  
  # static pages
  get  'home' => 'static_pages#home'
  get  'help' => 'static_pages#help'
  get  'about' => 'static_pages#about'
  get  'contact' => 'static_pages#contact'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
