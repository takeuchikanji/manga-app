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
      # 作者Bが２作品(b,c)もっている際に、片方削除するとBとbは削除されずcのみ削除される
      it "comicのみ1件削除される" do
        ## とりあえずもう一人作者(C)マンガ(c)用意して、cの作者をBに変更させておく
        @resistrated_comic_third = create(:comic, :comic_genre)
        visit edit_author_path(@resistrated_comic_third.author.id, @resistrated_comic_third.name)
        fill_in "author_name", with: @resistrated_comic_second.author.name
        # click_button "更新する"（ちなみにここでCは削除される）
        click_button "更新する"

        # マンガcの編集画面へ
        visit edit_author_path(@resistrated_comic_second.author.id, @resistrated_comic_third.name)
        # 削除してDBのテストする（1作品のみテストとコード違うが、挙動は同じ=>別解としてこっちも使う）
        click_link "削除する"     ## valueが"削除する"のとこをクリック
        expect {
          page.accept_confirm "この作品を削除しますか？"    ## ダイアログを許可する（引数にダイアログの内容を書く）
          expect(page).to have_content @resistrated_user.name
        }.to change{ Comic.count }.by(-1)

        ### 作者は変更しなかったことをテストする
        # expect {
        #   page.accept_confirm "この作品を削除しますか？"
        #   expect(page).to have_content @resistrated_user.name
        # }.to change{ Author.count }.by(0)   ##AuthorとComicを同時に0と-1で確認する方法がわからないかったので、Comicだけテストした（上ｺﾒﾝﾄｱｳﾄ、こっちｺﾒ外したらAuthorのテストになる）

        expect(current_path).to eq root_path
      end
    end
  end

end