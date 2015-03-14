Rails.application.routes.draw do

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
  #When logged in redirects to this page
  #Change later
  get     'logged_in' => 'sessions#logged_in'

  get 'users/index'

  get 'users/new'

  get 'users/edit'

  get 'users/delete'

  get 'users/show'

  get 'forums/created/:id' => 'forums#created', as: 'created'

  post 'forums/:id/join' => 'forums#join_forum', as:'join_forum'

  get 'users/:user_id/notifications' => 'notifications#index', as: 'user_notifications'

  get 'users/:user_id/notifications/:id' => 'notifications#show', as: 'user_notification'

  get 'users/indentation_error_message' => 'users#indentation_error_message'

  resources :users

  resources :forums do
    resources :ideas do
      resources :comments
    end
  end

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