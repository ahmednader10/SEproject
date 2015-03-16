
Rails.application.routes.draw do


  #################### Login #################################
  
  #Session Routes
  get    'login'   => 'sessions#new'

  post   'login'   => 'sessions#create'
  
  delete 'logout'  => 'sessions#destroy'
  
  get 'help' => 'sessions#help'
  
  get 'tempguest' => 'sessions#tempguest'
  
  get 'about' => 'sessions#about'
  
  get 'contactus' => 'sessions#contactus'
  
  get 'jobs' => 'sessions#jobs'
  
  get 'forgot' => 'sessions#forgot'
  
  ######################Facebook and Twitter Login###############################
  match 'auth/:provider/callback', to: 'sessions#createF', :via => [:get, :post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', :via => [:get, :post]
  ##############################################################################
  
  #When logged in normally or facebook redirects to this page
  #Change later

  get     'logged_in' => 'sessions#logged_in'
  ###########################################################



  get 'users/index'

  get 'users/new'

  get 'users/edit'

  get 'users/delete'

  get '/users/join_requests' => 'users#admin_join_forums_requests'

  get '/users/accept_join_request' => 'users#accept_join_request'

  get '/users/reject_join_request' => 'users#reject_join_request'

  get '/users/:id' => 'users#show'

  get '/users/profile/:id' => 'users#profile'

  get 'forums/created/:id' => 'forums#created', as: 'created'

  post 'forums/:id/join' => 'forums#join_forum', as:'join_forum'

  get 'notifications' => 'notifications#index', as: 'user_notifications'

  get 'users/indentation_error_message' => 'users#indentation_error_message'

  get 'search' => 'search#abdelghany'

  get 'forums/:id/ideas/new' => 'ideas#new', as: 'new_idea'

  post 'forums/:id/ideas/new' => 'ideas#create'

  resources :users 
  

  resources :forums do
    resources :ideas do
      resources :comments
    end


  end
  resources :friendships

   

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #Login as the Homepage
   root 'sessions#new'

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
