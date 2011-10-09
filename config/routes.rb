BetterSenseDemo::Application.routes.draw do

  devise_for :users
  devise_for :admins
  
  match '/admin' => "sysadmin#index", :as => :admin_root

  resources :campaigns

  resources :advertisers

  resources :ads

  match "sysadmin" => 'sysadmin#index'
  match "sysadmin/session_test" => 'sysadmin#session_test'

  match "demo" => 'demo#index'
  match "demo/:demo_name" => 'demo#servePage'

  match "regclick" => 'ads#regclick'
  match "regimpress" => 'ads#regimpress'

  resources :ad_sets

  match "ad_sets/:ad_set_id/createAd" => 'ad_sets#createAd'
  match "ad_sets/:ad_set_id/updateAd" => 'ad_sets#updateAd'
  match "ad_sets/:ad_set_id/getNewImage/:id" => 'ad_sets#getNewImage'

  get "tag/deliver"

  get "tag/display"

  resources :players

  resources :zones

  resources :networks

  resources :accounts
  
  match "account" => 'accounts#show'
  match "account/edit" => 'accounts#edit'

  get "kalturademo/index"
  match "kalturademo", :controller => 'kalturademo', :action => 'index'
  match "kalturademo/:vid_name" => 'kalturademo', :action => 'servePage'

  get "betterpic/list"

  get "betterpic/info"

  match "betterpic", :controller => 'betterpic', :action => 'index'
  match "betterpic/:iqeinfo_id", :controller => 'betterpic', :action => 'update'

  get "contact/index"

  match "contact", :controller => 'contact', :action => 'index'

  match "videos/:video_id/iqeinfos/:id/:action", :controller => 'iqeinfos', :action => /[a-zA-Z]+/i

  resources :videos do
    resources :iqeinfos
  end

  get "home/index"

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
   root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
