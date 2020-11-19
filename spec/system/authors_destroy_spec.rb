require 'rails_helper'

RSpec.describe "Authors", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)
    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
    @resistrated_comic = create(:comic, :comic_genre)
    @resistrated_comic_second = create(:comic, :comic_genre)
  end

  describe "作品を削除する" do
    context "1作品所持している作者を削除" do
      it "authorとcomic共にDBから削除される" do
        visit edit_author_path(@resistrated_comic.author.id, @resistrated_comic.name)
        expect {
          page.accept_confirm do
            find('#delete_button').click  ## 削除のリンクを探してクリック
          end
          expect(page).to have_content @resistrated_user.name     ## 処理が終わる前にcountで数えて、-1じゃなくてDBの変化ないよ！と怒られていたので、この処理(つまり削除されてrootに戻っている証)が終わってからchangeメソッドでテストするようにする
        }.to change{ Author.count }.by(-1)

        expect(current_path).to eq root_path
      end
    end

    context "2作品所持している作者を削除" do
    end
  end

end