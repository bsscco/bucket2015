Rails.application.routes.draw do
  resources :projects
  resources :cards

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'  }

  root 'cards#index'
end