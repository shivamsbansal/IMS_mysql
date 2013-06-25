Test2::Application.routes.draw do

  match '/consumables/withdraw/:id', to: 'consumables#withdraw', via: 'get'
  match '/show_stock/:id', to: 'stocks#show_stock', via: 'get'
  match '/issueConsumable', to: 'consumables#issueConsumable', via: 'put'
  match '/consumable_issue/:id', to: 'consumables#consumable_issue', via: 'get'
  match '/station_transfers', to: 'stocks#station_transfers', via: 'get'
  match '/transfers_list', to: 'stocks#transfers_list', via: 'get'
  match '/initialise_transfer_stock/:id', to: 'stocks#initialise_transfer_stock', via: 'get'
  match '/transfer_stock', to: 'stocks#transfer_stock', via: 'post'
  match '/acknowledge_receipt_stock/:id', to: 'stocks#acknowledge_receipt_stock', via: 'get' 
  match '/assets/withdraw_asset/:id', to: 'assets#withdraw_asset', via: 'get'
  match '/assets/issued_list/:id', to: 'assets#issued_list', via: 'get'
  match '/issueAsset', to: 'assets#issueAsset', via: 'put'
  match '/assets/associate_list', to: 'assets#associate_list', via: 'get'
  resources :assets, only: [:destroy]
  match '/assets/issue_asset/:id', to: 'assets#issue_asset', via: 'get'
  match '/asset_list/:id', to: 'assets#asset_list', via: 'get'
  match '/present_stock_update', to: 'stocks#present_stock_update', via: 'put'
  match '/present_stock_edit/:id', to: 'stocks#present_stock_edit', via: 'get'
  match '/stocks/itemList', to: 'stocks#itemList', via: 'get'
  match '/stocks/categoryList', to: 'stocks#categoryList', via: 'get'
  match '/stocks/choice', to: 'stocks#choice', via: 'get'
  match '/associates/list', to: 'associates#list', via: 'get'
  match '/details/:id', to: 'items#details' , via: 'get'
  match '/items/redirect', to: 'items#redirect', via: 'get'
  match '/items/list', to: 'items#list', via: 'get'
  resources :regions, :items, :territories, :vendors, :associates, :stocks

  resources :users
  resources :stations
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  root to:  'static_pages#home'
  
  match '/unassignedUser', to: 'users#assignUserform' ,via: 'get'
  match '/assignLevel', to: 'users#assignLevel' , via: 'put'
  match '/retainLevel/:id', to: 'users#retainLevel' , via: 'delete'
  match '/chooseLevel', to: 'users#chooseLevel' , via: 'get'
  #get '/signup' => 'users#new'
  match '/help', to: 'static_pages#help'
  match '/about',to: 'static_pages#about'
  match '/contact',to: 'static_pages#contact'
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
