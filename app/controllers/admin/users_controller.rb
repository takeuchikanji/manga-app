class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order("created_at DESC")
    @comics = Comic.all.order("created_at DESC")
    @authors = Author.all.order("created_at DESC")
    @genres = Genre.all.order("created_at DESC")
    @user = User.order(updated_at: :desc).limit(1)
    @comic = Comic.order(updated_at: :desc).limit(1)
    @author = Author.order(updated_at: :desc).limit(1)
    @genre = Genre.order(updated_at: :desc).limit(1)
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
