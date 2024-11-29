Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/AIAssistantCable'

  namespace :v1 do
    resources :messages, only: [:create]
    resources :threads, only: [:create]
    resources :assistants, only: [:show]
  end
end
