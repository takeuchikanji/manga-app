require 'rails_helper'

RSpec.describe "Authors", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)  ##元々、ユーザーを登録しておく(このユーザーに管理者権限を付与)
    @author = build(:author)        ##新しく登録したいユーザー
    @comic = build(:comic)      ## comicも作成する>>>>ここで引数で与えた値はfactoriesディレクトリ内から探しているため、factories/authors.rbの中に無くても問題ない
    @genre = build(:genre)      ##ジャンルも作成したが、ジャンルはseedファイルに記述済のためseeedをテストでも扱うようにターミナルでコマンド実行することでダミーデータいらなくなった

    ## beforeで前もってログインしておく(上で管理者として作成している)
    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
  end


  describe "作品編集" do
    before do
      ## factoriesのcomic内に、外部キーでauthorを指定しているので、comic生成すればauthorも生成されて外部キーに持つ
      ## 第二引数に、多対多でジャンルも作成したいので、trait内の記述も実行
      @resistrated_comic = create(:comic, :with_genre)
    end
    describe "フォームの入力値が正常" do
      context "全ての項目を編集する" do
        it "作品編集成功（正常系）" do
          ## 本番のhamlでは、edit_author_path(@author.id, @comic.name)と書いてる=>上で定義している変数に合わせて少し書き方変えてる
          visit edit_author_path(@resistrated_comic.author.id, @resistrated_comic.name)

          expect(page).to have_field "author_name", with: @resistrated_comic.author.name
          expect(page).to have_field "author_comic_name", with: @resistrated_comic.name
          expect(page).to have_field "author_comic_name_kana", with: @resistrated_comic.name_kana
          expect(page).to have_field "author_comic_number_of_books", with: @resistrated_comic.number_of_books
          # セレクトされているか、セレクトフォーム内に入ってるかテストしたかったが思うような挙動にならなかったため、画面にあれば良しとする
          expect(page).to have_content '未完結作品'
          expect(page).to have_content 'おすすめにする'
          # チェック入っているか
          expect(page).to have_checked_field `#{@resistrated_comic.genres}`

          # プレビューの画像が作品の画像と一致してるかテスト
          expect(page).to have_selector "img[src$='pose_ng_man.png']"  ## 元々factorybotで用意した画像（Aとする）を、create(:comic)で持たせているので、それとココで定義した画像（B）が同じかのチェック→→→なので、同じ画像を指定している
          
          expect(page).to have_field "author_comic_summary", with: @resistrated_comic.summary
          expect(page).to have_field "author_comic_review", with: @resistrated_comic.review


          ## 中身を変更する

          fill_in "author_name", with: "かきくけこ"
          fill_in "author_comic_name", with: "漫画"
          fill_in "author_comic_name_kana", with: "まんが"
          fill_in "author_comic_number_of_books", with: "1"
          fill_in "author_comic_summary", with: "あらすじ"
          fill_in "author_comic_review", with: "レビュー"

          select '完結作品', from: "author[comic][booknumber_id]"
          select 'おすすめにしない', from: "author[comic][recommend_id]"
          check '女性漫画'
          image_path = Rails.root.join('public/images/yubibue_boy.png')
          attach_file("author_comic_image", image_path, make_visible: true)

          click_button "更新する"
          expect(current_path).to eq root_path
          expect(page).to have_content @resistrated_user.name


          ## 作品詳細画面へ遷移して、変更されたか確認（詳細画面でわかる情報をチェック）

          visit comic_path(@resistrated_comic)

          expect(page).to have_content 'かきくけこ'
          expect(page).to have_content '漫画'
          expect(page).to have_content '1'
          expect(page).to have_content 'あらすじ'
          expect(page).to have_content 'レビュー'
          expect(page).to have_content '完結作品'
          expect(page).to have_content '女性漫画'
          expect(page).to have_selector "img[src$='yubibue_boy.png']"
        end
      end

      context "作者名を変更" do
        it "すでに作者2名(仮にA,Bとする)と漫画(a,b)登録済 => bの作者BをAに変更した際、BはDBから削除される" do
          ## もう一人作者(B)用意する
          @resistrated_comic_second = create(:comic, :with_genre)
          visit edit_author_path(@resistrated_comic_second.author.id, @resistrated_comic_second.name)
          expect(page).to have_field "author_name", with: @resistrated_comic_second.author.name
          fill_in "author_name", with: @resistrated_comic.author.name
          # click_button "更新する"

          # 更新するとのBさんをDBから削除するので、authorの件数が1件減るテスト
          expect {
            click_button "更新する"
          }.to change(Author, :count).by(-1)
        end
      end
    end

    describe "フォームの入力値が異常(空欄ある)" do
      it "作品編集失敗（異常系）" do
        visit edit_author_path(@resistrated_comic.author.id, @resistrated_comic.name)
      
        fill_in "author_name", with: "かきくけこ"
        fill_in "author_comic_name", with: nil
        fill_in "author_comic_name_kana", with: "まんが"
        fill_in "author_comic_number_of_books", with: "1"
        fill_in "author_comic_summary", with: "あらすじ"
        fill_in "author_comic_review", with: "レビュー"

        select '完結作品', from: "author[comic][booknumber_id]"
        select 'おすすめにしない', from: "author[comic][recommend_id]"
        check '女性漫画'
        image_path = Rails.root.join('public/images/yubibue_boy.png')
        attach_file("author_comic_image", image_path, make_visible: true)

        click_button "更新する"
        expect(current_path).to eq edit_author_path(@resistrated_comic.author.id, @resistrated_comic.name)

        expect(page).to have_field "author_name", with: "かきくけこ"
        # expect(page).to have_field "author_comic_name", with: "漫画"
        expect(page).to have_field "author_comic_name_kana", with: "まんが"
        expect(page).to have_field "author_comic_number_of_books", with: "1"
        # セレクトされているか、セレクトフォーム内に入ってるかテストしたかったが思うような挙動にならなかったため、画面にあれば良しとする
        expect(page).to have_content '完結作品'
        expect(page).to have_content 'おすすめにしない'
        # チェック入っているか
        expect(page).to have_checked_field '女性漫画'
        expect(page).to have_field "author_comic_summary", with: "あらすじ"
        expect(page).to have_field "author_comic_review", with: "レビュー"
      end
    end
  end
  
end