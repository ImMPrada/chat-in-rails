Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'profiles#show'

  resources :profiles, only: [:show]

  resources :workspaces, only: %i[show new create] do
    resources :channels, only: %i[new create]
  end
end
