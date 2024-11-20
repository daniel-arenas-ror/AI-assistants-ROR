Rails.application.routes.draw do
  mount ActionCable.server => '/AIAssistantCable'

  resources :messages, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
