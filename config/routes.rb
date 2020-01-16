Rails.application.routes.draw do
  resources :founders, only: [:update]
  resources :companies, only: [:update]

  root 'users#login' # ??? connect with other page!

  get 'auth0/password_reset_callback' => 'auth0#password_reset_callback'

  # everything in founder controller accessed by companies
  get 'search' => 'founders#index_anonymous'
  get 'search/founders/(:id)' => 'founders#show_anonymous'
  get 'founders/(:id)/connected' => 'founders#show'

  # everything in founder controller accessed by founder
  get 'founders/home' => 'founders#home'
  get 'founders/profile' => 'founders#show_profile'
  get 'founders/edit' => 'founders#edit'
  get 'founders/picture' => 'founders#edit_profile_picture'
  post 'founders/picture' => 'founders#update_profile_picture'
  get 'founders/company_contacts' => 'founders#company_contacts'

  #create new founder as an admin
  get 'founders/new_admin' => 'founders#new_admin'
  post 'founders/new_admin' => 'founders#create_admin'
  post 'founders/publish' => 'founders#publish'
  # get 'founders/(:id)/payment_overview' => 'founders#payment_overview'
  # get 'founders/(:id)/payment_settings' => 'founders#payment_settings'
  
  # everything in company controller accessed by company
  get 'companies/home' => 'companies#home'
  get 'companies/profile' => 'companies#show' 
  get 'companies/edit' => 'companies#edit' 
  get 'companies/picture' => 'companies#edit_profile_picture'
  post 'companies/picture' => 'companies#update_profile_picture'
  get 'companies/contacted_founders' => 'companies#contacted_founders'
  get 'companies/payment_overview' => 'companies#payment_overview'
  post 'companies/(:id)/mark_as_hired' => 'companies#mark_as_hired'
  post 'companies/(:id)/mark_as_not_hired' => 'companies#mark_as_not_hired'

  get 'contacts/payment' => 'contacts#payment'
  post 'contacts/create' => 'contacts#create'

  get 'companies/new_admin' => 'companies#new_admin'
  post 'companies/new_admin' => 'companies#create_admin'
  
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  post 'auth/password_reset' => 'auth0#password_reset'

  get 'login' => 'users#login'
  get 'logout' => 'logout#logout'

  post 'stripe_webhooks/payment_successful' => 'stripe_webhooks#payment_successful'

  # for stripe payment
  resources :charges, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
