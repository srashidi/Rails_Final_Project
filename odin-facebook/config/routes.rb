Rails.application.routes.draw do

  get 'friendships/show'
  get 'friendships/pending'

  devise_for :users, :controllers => { registrations: 'custom/registrations',
  																		 sessions: 'custom/sessions',
  																		 omniauth_callbacks: 'custom/omniauth_callbacks' }
  resources :users, only: [:show, :index]

  resources :comments, only: [:create, :destroy]
  resources :posts, only: [:create, :index, :destroy] do
  	resources :likes, only: [:create, :destroy]
  end

  resources :friendships do
  	member do
  		put 'friend_request'
  		put 'friend_request_accept'
  		delete 'friend_request_reject'
  	end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

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
