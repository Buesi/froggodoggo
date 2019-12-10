Rails.application.routes.draw do
  # get 'founders/new'
  resources :founders

  resources :companies 

  root 'founders#new'

  get 'search' => 'founders#index_anonymous'
  get 'search/founders/(:id)' => 'founders#show_anonymous'
  get 'founders/(:id)/home' => 'founders#home'
  get 'founders/(:id)/show_profile' => 'founders#show_profile'
  get 'founders/(:id)/payment_overview' => 'founders#payment_overview'
  get 'founders/(:id)/payment_settings' => 'founders#payment_settings'
  get 'contacts/payment' => 'contacts#payment'

  post 'contacts/create' => 'contacts#create'
  post 'stripe_webhooks/payment_successful' => 'stripe_webhooks#payment_successful'

  # for stripe payment
  resources :charges, only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
