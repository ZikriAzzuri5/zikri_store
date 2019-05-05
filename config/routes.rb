Rails.application.routes.draw do
  root 'home#index'

  resources :products do
    member do
      get :update_stock
      patch :stock_update
      post :add_to_cart
    end
  end

  resources :confirmations, only: [:new, :create] do
    member do
      get :confirm
    end

    collection do
      post :send_password
    end
  end

  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy] do
    member do
      get :reset_password
      patch :update_password
    end
    collection do
      get :forgot
    end
  end
  resources :categories
  resources :cart_items, only: [:destroy, :update]

  resources :orders do
    member do
      get :checkout
    end
  end

  resource :cart,  only: [:show, :update, :destroy] do
    collection do
      get :sad
      get :checkout
    end
  end



  get 'signup', to: 'registrations#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
