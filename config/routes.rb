Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get '/users', to: redirect("/users/sign_up")    ##新規登録時renderでパスが/usersになるので、そこでリロードしたときにエラーが出てしまう（それ防止のためにリダイレクトさせる）
  root "authors#index"
  resources :comics, only: [:index, :new, :create, :show] do
    collection do
      get 'search'
    end
    resource :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :genres, only: [:new, :create]
  resources :authors
  resources :users, only: :show do
    get 'showbookmark'
  end
end
