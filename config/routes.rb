Rails.application.routes.draw do
  root "comics#index"
  get 'comics/index'
end
