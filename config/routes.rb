
Rails.application.routes.draw do


  ####################### SysAdmin ###########################

  get 'sysadmins/new' => 'sysadmins#new', as: 'new'

  get 'sysadmins/index' => 'sysadmins#index', as: 'index'

  get 'sysadmins/show' => 'sysadmins#show', as: 'show'

  get 'sysadmins/edit' => 'sysadmins#edit', as: 'edit'

  get 'sysadmins/delete'

  get 'sysadmins/merge' => 'sysadmins#merge'

  post 'sysadmins/show' => 'sysadmins#show'

  post 'sysadmins/merge' => 'sysadmins#createMerge'

  get 'sysadmins/forums' => 'sysadmins#forums', as: 'forums_sysadmins'

  get 'sysadmins/userBlocked' => 'sysadmins#userBlocked', as: 'blocked'

  get 'sysadmins/userUnblocked' => 'sysadmins#userUnblocked', as: 'unblocked'

  get 'sysadmins/deleteUser' => 'sysadmins#deleteUser', as: 'deleteUser'

  get 'sysadmins/missingUser' => 'sysadmins#missingUser', as: 'missingUser'

  get 'sysadmins/test'

  ############### Admin ######################################

  get 'admins/index'

  get 'admins/show'

  get 'admins/new'

  get 'admins/edit'

  get 'admins/delete'

  #################### Login #################################

  #Session Routes
  get    'login'   => 'sessions#new'

  post   'login'   => 'sessions#create'

  delete 'logout'  => 'sessions#destroy', as: 'logout'

  get 'help' => 'sessions#help', as: 'help'

  get 'tempguest' => 'sessions#tempguest'

  get 'about' => 'sessions#about'

  get 'contactus' => 'sessions#contactus'

  get 'jobs' => 'sessions#jobs'

  get 'forgot' => 'sessions#forgot'

  get 'forgotpw/new' => 'forgotpw#new'

  post 'forgotpw/sendx' => 'forgotpw#sendx'

  ######################Facebook and Twitter Login###############################
  match 'auth/:provider/callback', to: 'sessions#createF', :via => [:get, :post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', :via => [:get, :post]


  ####################### Social share button ##################################
  resources :homes, only: [:show]
  get 'share' => 'homes#show'


  #When logged in normally or facebook redirects to this page
  #Change later

  get 'logged_in' => 'sessions#logged_in'
  ############################ Users ###############################

  get 'users/index'

  get 'users/new'

  get 'users/edit'

  get 'users/show'

  get 'users/delete'

  get '/users/join_requests' => 'users#admin_join_forums_requests'

  get '/users/accept_join_request' => 'users#accept_join_request'

  get '/users/reject_join_request' => 'users#reject_join_request'

  get '/users/:id' => 'users#show'

  get '/users/profile/:id' => 'users#profile', as: 'profile'

  get 'users/profile/:id/removeAvatar' => 'users#deleteImage' , as: 'deleteImage'

  ############################ Forums ########################################

  get 'forums/created/:id' => 'forums#created', as: 'created'

  post 'forums/:id/join' => 'forums#join_forum', as:'join_forum'

  get 'forums/:id/members' => 'forums#list_members', as:'list_members'

  delete 'forums/:forum_id/ideas/:id' => 'ideas#destroy', as: 'delete_idea'

  post 'forums/:forum_id/ideas/:id/like' => 'ideas#like', as: 'like_idea'

  post 'forums/:forum_id/ideas/:id/unlike' => 'ideas#unlike', as: 'unlike_idea'

  #post '/forums/:forum_id/ideas/:id/unreport' => 'ideas#unreport', as: 'unreport_idea'

  get 'forums/leaveforum' => 'forums#leave_forum', as: 'leave_forum'

  get 'forums/canceljoinrequest' => 'forums#cancel_join_request', as: 'cancel_join_request'

  get 'forums/remove_member' => 'forums#remove_member', as:'remove_member'

  get 'forums/:forum_id/admins/:id' => 'admins#createAdmin', as: 'add_admin'

  ############################ Notifications #################################

  get 'notifications' => 'notifications#index', as: 'user_notifications'

  get 'notifications/:id/delete' => 'notifications#destroy'

  get 'notifications/:id/seen' => 'notifications#markSeen'

  get 'notifications/seenall' => 'notifications#markAllSeen'

  ############################### System log #################################

  get 'syslogall' => 'actions#indexall'

  get 'syslog' => 'actions#index'

  get 'syslog/hide/:id' => 'actions#hide' , as:'hide1'

  get 'syslog/unhide/:id' => 'actions#unhide'

  get 'syslog/hideall' => 'actions#hideall'

  get 'syslog/unhideall' => 'actions#unhideall'

  ############################################################################

  #get 'users/indentation_error_message' => 'users#indentation_error_message'

  get 'search' => 'search#search'

  post 'search' => 'search#search'

  get 'advancedsearch' => 'search#advanced_search'

  post 'forums/:id/admins/new' => 'admins#new', as: 'admin_to_be'

  get 'admins/unauthorized_action' => 'admins#unauthorized_action', as: 'unauthorized_action'

  get 'admins/wrong_email' => 'admins#wrong_email', as: 'wrong_email'

  get 'admins/added_admin' => 'admins#added_admin', as: 'added_admin'

  get 'sessions/blockingMessage' => 'sessions#create', as: 'blocking_message'

  post 'forums/show' => 'forums#show'

  get 'forums/new' => 'forums#new', as: 'new_forum'


  ###########################################################

  get 'user/:id/friends' => 'friendships#index', as: 'friends'

  get 'user/:id/requests' => 'friendships#requests'

  get 'friendships/:id/accept' => 'friendships#accept'

  get 'friendships/:id/reject' => 'friendships#reject'

  # get 'sysAdmin'
  # get 'forums/:id/ideas/new' => 'ideas#new', as: 'new_idea'
  # post 'forums/:id/ideas/new' => 'ideas#create'

  resources :users do
    post :block_user
    post :report_user
    resources :friendships do
      #put :update
      put :reject
    end
  end

  resources :forums do
    resources :admins
  end

  resources :forums do
    resources :ideas do
      member do
        post :like
        post :unlike
        post :report
        post :unreport
        post :destroy
      end
      resources :comments do
      member do
        post :reportcomment
        post :unreportcomment
       end
     end
   end
  end

delete 'forums/:forum_id/ideas/:idea_id/comments/:id' => 'comments#destroy', as: 'comment_delete'

  resources :friendships do
    #put :update
    put :reject
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Login as the homepage
  # To be changed later
   root 'sessions#index'

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
