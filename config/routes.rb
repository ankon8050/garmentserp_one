Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'homes#index'

get 'typeahead/:query' => 'buyer_profile_table#typeahead'

resources :orders do 
      collection do 
  
      post :order_master_input
      get :order_master_input
      post :add_order
   
     
  
                    end
                 end


resources :homes do 
      collection do 
  
      get :admin
      get :search_status
     
  
                    end
                 end

  resources :styles do 
      collection do 
  
      post :style_master_input
      get :style_master_input
      post :add_style
      get :get_buyer_profile_lots
  
                    end
                 end

  resources :buyers do 
      collection do 

      post :buyer_all
      get  :buyer_create
  
                   end
                end

  resources :cuttings do 
      collection do 
  
      post :cutting_search
      get :search
      get :cutting_search
      post :cutting_lineman
      get :get_buyer_profile_lots
      get :cutting_show
      get :cutting_show_one
      get :get_buyer_profile_styles
      get :get_buyer_profile_colors
      get :get_buyer_profile_orderq
      get :get_buyer_profile_product_name
                    end
                 end


  resources :sewings do 
      collection do 
  
      post :sewing_search
      get :sewing_search
      post :sewing_lineman
      post :sewing_master_input
      get :get_buyer_profile_lots
      get :sewing_show_one
      get :get_buyer_profile_styles
      get :sewing_machine_input
      get :get_buyer_profile_product_name
      get :sewing_show
      post :sewing_show
                    end
                 end


                  resources :finishings do 
      collection do 
  
     post :finishing_search
      get :finishing_search
      post :finishing_lineman
      get :get_buyer_profile_lots
      get :finishing_show
      get :finishing_show_one
      get :get_buyer_profile_styles
      get :get_buyer_profile_colors
      get :get_buyer_profile_orderq
      get :get_buyer_profile_product_name
                    end
                 end


                         resources :temps do 
      collection do 
  
      post :temp_enter
     
     
  
                    end
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
