Rails.application.routes.draw do
  mount ActionCable.server => '/AIAssistantCable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
