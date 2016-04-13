Rails.application.routes.draw do
  get 'welcome/index'

  resources :users do
    member do
      # TODO - is there any need for a separate login/signin/authentication controller?
      # TODO - maybe have an authentication class as a concern?
      post 'signin'
      get 'reset_password'
    end

    collection do
    end

    # we only care about the definitions as scoped to their owner (user)
    # admin actions are the exception
    resources :board_definitions do
      resources :cell_options
    end

    # we only need to act on a GameBoard within the context of a player (user)
    # admin actions are the exception
    resources :game_boards do

    end
  end

  # TODO - flesh out the API for Game and sub-resource GameBoard (sub-resource of user and/or game?)
  resources :games do
    # * create      (create a new games entry)
    # * join        (create a new board for a game and player/user (may be done before or during game play))
    # * start       (opens a game for play)
    # * mark        (send board's x,y coords => returns true if board is the winner; false if not and play is closed; nil if not and play is open)
    # * stats       (winner email, all cell_options "marked")
    # * delete      (owner can call in any state; auto-deleted after configurable time, defaulting to 24 hours)
  end


  root 'welcome#index'

  #
  # Comments/Examples from rails-generated routes.rb file...
  #

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  # resources :products

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
