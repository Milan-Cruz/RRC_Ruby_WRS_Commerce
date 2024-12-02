Rails.application.routes.draw do
  # Root path
  root "home#index"

  # Categories
  resources :categories, only: [:index, :show]

  # Orders
  resources :orders, only: [:new, :create, :index, :show]

  # Checkout (singular resource for single checkout instance)
  resource :checkout, only: [:show, :create] do
    post :finalize_order, on: :collection # Action to finalize order without payment
  end

  # Cars
  resources :cars, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  # User profile
  get "profile", to: "users#show", as: :user_profile

  # Cart (singular resource for single cart instance)
  resource :cart, only: [:show] do
    post :add_item
    post :update_item
    delete :remove_item
  end

  # Fake PayPal Simulation
  get "fake_paypal", to: "fake_payments#show", as: :fake_paypal
  post "fake_paypal/confirm", to: "fake_payments#confirm", as: :fake_paypal_confirm
  post "fake_paypal/cancel", to: "fake_payments#cancel", as: :fake_paypal_cancel

  # Payments (for PayPal integration)
  resources :payments, only: [:create] do
    collection do
      get :success # Para redirecionamento de sucesso do PayPal
      get :cancel  # Para redirecionamento de cancelamento do PayPal
    end
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
