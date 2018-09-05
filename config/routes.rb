Rails.application.routes.draw do
  resources :advices
  resources :projects
  resources :cards

  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}

  root 'cards#index'

  get 'users/:id' => 'users#show', as: :user
  get 'users/:id/cards' => 'users#cards', as: :user_cards
  get 'users/:id/projects' => 'users#projects', as: :user_projects
end