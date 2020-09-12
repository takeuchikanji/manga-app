Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root "authors#index"
  resources :comics, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
  resources :genres, only: [:new, :create]
  resources :authors
end
