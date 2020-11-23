Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    resources :users
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get '/users', to: redirect("/users/sign_up")    ##新規登録時renderでパスが/usersになるので、そこでリロードしたときにエラーが出てしまう（それ防止のためにリダイレクトさせる）
  root "comics#recommend"
  resources :comics, only: [:index, :new, :create, :show] do
    collection do
      get 'search'
      get 'searchscreen'
      get 'recommend'
    end
    resource :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :genres, only: [:new, :create]
  resources :authors
  resources :users, only: :show do
    get 'showbookmark'
    resources :requests, only: [:index, :new, :create, :destroy, :show]
  end
end
