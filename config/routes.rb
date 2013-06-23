Blog::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

  resources :posts, :except => :show do
    resources :comments, :only => [:create, :destroy, :new]
  end
  get '/posts/:slug' => 'posts#show', :as => :show_post
  get '/feed' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }

  resources :users
  # get '/admin/signin' => 'devise/sessions#new', :as => :new_user_session
  # post '/admin/signin' => 'devise/sessions#create', :as => :user_session
  # delete '/admin/signout' => 'devise/sessions#delete', :as => :destroy_user_session


  controller :admins do
    get '/admin' => 'admins#index', :as => :get_admin
    get '/admin/:id/show' => 'admins#show', :as => :admin_show
  end

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
