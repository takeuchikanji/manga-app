Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root "comics#index"
  resources :comics, only: [:new, :create]
  resources :genres, only: [:new, :create]
  resources :authors, only: [:new, :create, :edit, :update, :destroy, :show]
end
