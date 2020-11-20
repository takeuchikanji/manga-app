require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)
    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
    @resistrated_comic = create(:comic, :comic_genre)
  end

  describe "コメント機能" do

    it "コメントをしたい作品のコメントページなのか" do
      visit comic_comments_path(@resistrated_comic.id)
      expect(page).to have_content @resistrated_comic.name
    end

    it "コメントする" do
      ## コメント画面へ遷移
      visit comic_comments_path(@resistrated_comic.id)
      fill_in "comment_text", with: "コメントのテスト"
      click_button "投稿"
      expect {
        expect(page).to have_content "コメントのテスト" ## コメントが画面上にあるか
      }.to change{ Comment.count }.by(+1)
    end

    it "コメント削除", js: true do
      # 投稿しておく
      visit comic_comments_path(@resistrated_comic.id)
      fill_in "comment_text", with: "コメントのテスト"
      click_button "投稿"
      expect(page).to have_content "コメントのテスト"

      ## コメント削除する
      ## 削除のリンク(aタグに付与したid=comment_d_btnは見つからないと言われるvisible: falseつけても変化なし)を探す
      ### なので、ゴミ箱アイコンのクラスを指定した！
      find('.trash-icon').click  
      ## コメントがDBから減ったかテスト
      expect {
        expect(page).to_not have_content "コメントのテスト"  ##投稿したコメントがないのを確認
      }.to change{ Comment.count }.by(-1)
    end
  end
end

