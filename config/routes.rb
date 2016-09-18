Rails.application.routes.draw do

  post 'finance_api/responce_status/:id' => 'finance_api#responce_status'

  get 'finance_api/success/:id' => 'finance_api#success'
  post 'finance_api/success/:id' => 'finance_api#success'

  get 'finance_api/error/:id' => 'finance_api#error'
  post 'finance_api/error/:id' => 'finance_api#error'
  get '/finance_api/payment_form' => 'finance_api#payment_form'
  resources :businesses
  resources :users, controller: 'profile', path: 'profile'
  root 'landing#index'
  get 'home' => 'home#index'
  get 'team' => 'team#index'
  get '/p/:id' => 'partner_link#partner', as: "partner_link"
  delete '/p' => 'partner_link#delete', as: "delete_partner_session"
  match '/profile/:id/finish_signup' => 'profile#finish_signup', via: [:get, :patch], :as => :finish_signup
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

  # Admin Pages
  namespace :admin do
    get '/', to: 'home#index'
    get 'users', to: 'users#index'
    get 'user/:id', to: 'users#show', as: :user
    delete 'user/:id', to: 'users#destroy', as: :delete_user
    post 'user/:id/changerole', to: 'users#changerole'
    get 'payments', to: 'payments#index'
  end
  # All routes
  #get "dashboards/dashboard_1"
  #get "dashboards/dashboard_2"
  #get "dashboards/dashboard_3"
  #get "dashboards/dashboard_4"
  #get "dashboards/dashboard_4_1"

  #get "layoutsoptions/index"
  #get "layoutsoptions/off_canvas"

  #get "graphs/flot"
  #get "graphs/morris"
  #get "graphs/rickshaw"
  #get "graphs/chartjs"
  #get "graphs/peity"
  #get "graphs/sparkline"

  #get "mailbox/inbox"
  #get "mailbox/email_view"
  #get "mailbox/compose_email"
  #get "mailbox/email_templates"
  #get "mailbox/basic_action_email"
  #get "mailbox/alert_email"
  #get "mailbox/billing_email"

  #get "wid#gets/index"

  #get "forms/basic_forms"
  #get "forms/advanced"
  #get "forms/wizard"
  #get "forms/file_upload"
  #get "forms/text_editor"

  #get "appviews/contacts"
  #get "appviews/profile"
  #get "appviews/projects"
  #get "appviews/project_detail"
  #get "appviews/file_menager"
  #get "appviews/calendar"
  #get "appviews/faq"
  #get "appviews/timeline"
  #get "appviews/pin_board"
  #get "appviews/teams_board"
  #get "appviews/clients"
  #get "appviews/outlook_view"
  #get "appviews/blog"
  #get "appviews/article"
  #get "appviews/issue_tracker"

  #get "pages/search_results"
  #get "pages/lockscreen"
  #get "pages/invoice"
  #get "pages/invoice_print"
  #get "pages/login"
  #get "pages/login_2"
  #get "pages/forgot_password"
  #get "pages/register"
  #get "pages/not_found_error"
  #get "pages/internal_server_error"
  #get "pages/empty_page"

  #get "miscellaneous/notification"
  #get "miscellaneous/nestablelist"
  #get "miscellaneous/timeline_second_version"
  #get "miscellaneous/forum_view"
  #get "miscellaneous/forum_post_view"
  #get "miscellaneous/google_maps"
  #get "miscellaneous/code_editor"
  #get "miscellaneous/modal_window"
  #get "miscellaneous/validation"
  #get "miscellaneous/tree_view"
  #get "miscellaneous/chat_view"
  #get "miscellaneous/agile_board"
  #get "miscellaneous/diff"
  #get "miscellaneous/idle_timer"
  #get "miscellaneous/spinners"
  #get "miscellaneous/live_favicon"

  #get "uielements/typography"
  #get "uielements/icons"
  #get "uielements/draggable_panels"
  #get "uielements/buttons"
  #get "uielements/video"
  #get "uielements/tables_panels"
  #get "uielements/notifications_tooltips"
  #get "uielements/badges_labels_progress"

  #get "gridoptions/index"

  #get "tables/static_tables"
  #get "tables/data_tables"
  #get "tables/jqgrid"

  #get "gallery/basic_gallery"
  #get "gallery/bootstrap_carusela"

  #get "cssanimations/index"

  #get "landing/index"

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
