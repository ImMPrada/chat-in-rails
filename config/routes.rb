Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  mount ActionCable.server => '/cable'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'profiles#show'

  resources :profiles, only: [:show]

  resources :invitations, only: %i[show], param: :token
  
  resources :workspaces, only: %i[show new create] do
    resources :invitations, only: %i[create]

    resources :channels, only: %i[index show new create] do
      resources :messages, only: %i[index create]
    end

    resources :users, only: %i[show] do
      resources :messages, only: %i[create]
    end
  end
end
