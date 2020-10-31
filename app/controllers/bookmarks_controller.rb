class BookmarksController < ApplicationController
  before_action :set_comic
  before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

  def create
    @bookmark = Bookmark.create(user_id: current_user.id, comic_id: @comic.id)
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, comic_id: @comic.id)
    @bookmark.destroy
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end
end
