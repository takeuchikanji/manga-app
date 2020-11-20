require 'rails_helper'

RSpec.describe "Authors", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)
    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
    @resistrated_comic = create(:comic, :comic_genre)
  end

  describe "ブックマーク機能" do
    it "ブックマークする" do
      ## comic詳細へ遷移
      visit comic_path(@resistrated_comic.id)
      expect {
        find('#book_off').click  ## ブックマークのリンクを探してクリック
        expect(page).to have_css '.bookmark-on' ## DB反映前にcountみてしまうので、ブクマアイコンの変化を確認するテストを挟む
      }.to change{ Bookmark.count }.by(+1)
    end

    it "ブックマーク解除" do
      visit comic_path(@resistrated_comic.id)
      # ブクマしておく
      find('#book_off').click
      # 処理速すぎて一旦テスト挟んで、DB反映を待つ
      expect(page).to have_css '.bookmark-on'
      # ブクマしたbtnを再度クリックしてブクマ解除
      expect {
        find('#book_on').click  ## ブックマークのリンクを探してクリック
        expect(page).to have_css '.bookmark-off'  ##offのクラス名があるのを確認
      }.to change{ Bookmark.count }.by(-1)
    end
  end
end

