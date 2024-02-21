# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end
    get '/users/me', to: 'users#me'
    resources :parking_lots do
      post '/park', to: 'parking_lots#park'
      post '/unpark', to: 'parking_lots#unpark'
      post '/create_parking_slots', to: 'parking_lots#create_parking_slots'
      post '/add_accessways', to: 'parking_lots#add_accessways'
    end
    
  end
end

scope :api do
  scope :v1 do
    # Swagger documentation
    scope :swagger do
      get '/', to: 'apidocs#index', as: :swagger_root
      get '/data', to: 'apidocs#data', as: :swagger_data
    end
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end
  end
end
