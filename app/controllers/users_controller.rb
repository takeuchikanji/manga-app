class UsersController < ApplicationController

  def showbookmark
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:comic_id)  # ログイン中のユーザーのお気に入りのitem_idカラムを取得(.pluckを使って、bookmarkテーブル内でログインユーザーのidを持ってるitem_idを取得
    @bookmark_list = Comic.find(bookmarks)     # bookmarksテーブルから、お気に入り登録済みのレコードを取得
  end
end
