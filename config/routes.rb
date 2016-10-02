Rails.application.routes.draw do

  root 'landing#index'
  get 'home' => 'home#index'

  post 'finance_api/responce_status/:id' => 'finance_api#responce_status'
  post 'finance_api/output' => 'finance_api#output'
  
  get 'finance_api/success/:id' => 'finance_api#success'
  post 'finance_api/success/:id' => 'finance_api#success'
  
  get 'finance_api/error/:id' => 'finance_api#error'
  post 'finance_api/error/:id' => 'finance_api#error'
  
  get '/finance_api/payment_form' => 'finance_api#payment_form'


  get 'team/:id', to: 'team#user_team', as: 'user_team'
  get 'team' => 'team#index'
  post 'team' => 'team#index'
  
  get '/p/:id' => 'partner_link#partner', as: 'partner_link'
  post '/p/:id' => 'partner_link#landing', as: 'landing_link'
  delete '/p' => 'partner_link#delete', as: 'delete_partner_session'
  
  get '/landings', to: 'instruments/landings#index', as: 'landings'
  get '/landings/:id', to: 'instruments/landings#show', as: 'landing'
  post '/landings/:id', to: 'instruments/landings#activate', as: 'activate_landing'
  #resources :landings, only: [:index, :activate], path: 'landings', controller:'instruments/landings'
  
  resources :users, controller: 'profile', path: 'profile'
  match '/profile/:id/finish_signup' => 'profile#finish_signup', via: [:get, :patch], :as => :finish_signup
  post '/profile/status', to: 'profile#change_role'
  
  devise_for :users, controllers:
    {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    },
    path: '',
    path_names: {
      sign_in: 'login',
      sign_up: 'register',
      password: 'passwords'
    }
    patch '/admin/withdrawals/:id/' => 'admin/withdrawals#update', as: :withdrawal

  # Admin Pages
  namespace :admin do
    get '/', to: 'home#index'
    get 'users', to: 'users#index'
    get 'user/:id', to: 'users#show', as: :user
    delete 'user/:id', to: 'users#destroy', as: :delete_user
    post 'user/:id/changerole', to: 'users#changerole'
    post 'user/:id/changeparent', to: 'users#changeparent'
    post 'users/parse.json', to: 'users#parse'
    post 'user/:id/givebonus', to: 'users#givebonus', as: :give_bonus
    get 'payments', to: 'payments#index'
    put 'payments/transfer', to: 'payments#transfer'
    resources :withdrawals, only: [:index, :show, :update, :destroy]
    resources :landings, only: [:index, :show], path: 'landings', controller:'instruments/landings'
  end
  # All routes
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
