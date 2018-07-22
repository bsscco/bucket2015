Rails.application.routes.draw do
  resources :projects
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'cards#index'

  resources :cards

end