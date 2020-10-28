Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get '/users', to: redirect("/users/sign_up")    ##新規登録時renderでパスが/usersになるので、そこでリロードしたときにエラーが出てしまう（それ防止のためにリダイレクトさせる）
  root "authors#index"
  resources :comics, only: [:index, :new, :create] do
    collection do
      get 'search'
    end
  end
  resources :genres, only: [:new, :create]
  resources :authors
end
