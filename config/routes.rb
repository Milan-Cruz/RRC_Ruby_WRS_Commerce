Rails.application.routes.draw do
  get "orders/new"
  get "orders/create"
  get "orders/index"
  get "orders/show"
  # Root path
  root "home#index"

  # Categories
  resources :categories, only: [:index, :show]

  # Orders
  resources :orders, only: [:new, :create, :index, :show]

  # Cars
  resources :cars, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  # User profile
  get "profile", to: "users#show", as: :user_profile

  # Carts
  resource :cart, only: [:show] do
    post :add_item
    post :update_item
    delete :remove_item
  end

  # Devise routes for users and admin users
  devise_for :users, controllers: {
                       sessions: "devise/sessions",
                     }, sign_out_via: [:delete, :get]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end
