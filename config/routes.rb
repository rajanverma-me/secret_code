Rails.application.routes.draw do
  
  root 'home#index'

  # Route to newly generated registration controller
  devise_for :users, controllers: { registrations: "registrations" }

	# These two paths are only accessible to admin
  get '/secrets', to: "secret_code#index"
  post '/deliver_code', to: "secret_code#deliver_code"
  post '/secrets/generate', to: "secret_code#generate_secret_code" 
end
