Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'search/index' => 'search#index', :as => :search

  post 'profile/:for_user_id/review' => "profile#create_review", :as => :create_review

  match 'register' => 'register#step1', :via => [:get, :post], :as => :register
  match 'register2' => 'register#step2', :via => [:get, :post], :as => :register2
  match 'register3' => 'register#step3', :via => [:get, :post], :as => :register3
  match 'register4' => 'register#step4', :via => [:get, :post], :as => :register4

  get 'profile/private' => 'profile#private', :via => [:get], :as => :profile_private
  get 'profile/:user_id' => 'profile#show', :via => [:get], :as => :profile
  
  get 'settings' => 'profile#settings', :viat => [:get], :as => :settings

  match 'login' => 'profile#login', :via => [:get, :post], :as => :login
  get 'logout' => 'profile#logout', :as => :logout

  get 'home/index'
  get 'home/:profession/specialities' => 'home#specialities', :as => :specialities_for_profession

  root 'home#index'

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
