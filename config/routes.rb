Sill::Application.routes.draw do
  resources :posts

  match 'home' => 'system#index', :as => :home
  match 'system' => 'system#index', :as => :system
  match 'welcome' => 'system#welcome', :as => :welcome
  match 'SysFacade.getSysConfig' => 'system#sysConfig'

  match 'login' => 'sessions#login', :as => :login
  match 'logout' => 'sessions#logout', :as => :logout
  # match 'signup' => 'users#new', :as => :signup

  match 'users/select_group', :controller => 'users', :action => 'select_group'
  match 'users/set_groups', :controller => 'users', :action => 'set_groups'

  resources :users
  # resources :sessions

  match 'groups/select_user', :controller => 'groups', :action => 'select_user'
  match 'groups/set_users', :controller => 'groups', :action => 'set_users'
  resources :groups

  # category_tree use extjs
  resources :categories #:only => [:index]
  match 'category/category_tree', :controller => 'categories', :action => 'category_tree'
  match 'category/json', :controller => 'categories', :action => 'index_json'
  match 'category/layout', :controller => 'categories', :action => 'layout'

  # resource
  match 'resource/modules', :controller => 'resources', :action => 'get_module'
  match 'resource/json', :controller => 'resources', :action => 'index_json'

  root :to => 'sessions#login'

  match '/about', :to => 'static#about', :as => :about

  # 保持传统格式
  match ':controller(/:action(/:id(.:format)))'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.

end
