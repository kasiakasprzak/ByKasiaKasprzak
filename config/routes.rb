Rails.application.routes.draw do
  devise_for :admins, :controllers => { registrations: 'admin/registrations' }
  devise_for :users, :controllers => { registrations: 'creator/registrations' }
  
  get 'welcome/index'
  root 'welcome#index'

  namespace :admin do
    root to: 'dashboard#index'

    resource :dashboard
    resources :users
    resources :admins
    resources :orders
    resources :colors
    resources :collections
    resources :color_positions
    resources :bracelets do
      collection do
        get 'pallete'
        get 'change'
        get 'changerow'
        get 'changeentiretable'
      end
    end
  end

  namespace :creator do
    get 'order_items/create'
    get 'order_items/update'
    get 'order_items/destroy'
    get 'carts/show'
    post 'orders/change_order_status'
    resources :users
    resources :orders do
      collection do
        get 'show_shipping_address'
        get 'edit_shipping_address'
      end
    end
    resources :order_status
    resources :collections
    resources :colors, only: [:show, :index]
    resources :color_positions
    resources :order_items, only: [:create, :update, :destroy] do
      collection do
        get 'cart_row'
        get 'shopping_cart'
      end
    end
    resources :bracelets do
      member do
        get 'copy'
      end
      collection do
        get 'update_sum_price'
        get 'pallete'
        get 'change'
        get 'changerow'
        get 'changeentiretable'
        get 'draft_list'
      end
    end
  end


    
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
