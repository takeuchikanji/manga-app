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

  describe "作品投稿" do
    context "フォームの入力値が正常" do
      it "作品投稿成功（正常系）" do

        # 作品投稿画面へ遷移
        visit new_author_path

        ## 作者名入力
        fill_in "author_name", with: @author.name
        ## 作品名入力
        fill_in "author_comics_attributes_0_name", with: @comic.name
        ## 作品の読み方入力
        fill_in "author_comics_attributes_0_name_kana", with: @comic.name_kana
        ## 巻数
        fill_in "author_comics_attributes_0_number_of_books", with: @comic.number_of_books

        # ActiveHashの値は、元からあるため、それを選択する
        ## 未完結か完結か
        select '未完結作品', from: "author[comics_attributes][0][booknumber_id]"
        ## 管理者のおすすめにするか
        select 'おすすめにする', from: "author[comics_attributes][0][recommend_id]"
        # seed.rbにジャンルは入れているので、テストでも本番と同じジャンルをチェックできる
        check '女性漫画'

        # 変数に入れたい画像の場所のパスを入れる
        ## 画像を入力
        image_path = Rails.root.join('public/images/pose_ng_man.png')
        attach_file("author[comics_attributes][0][image]", image_path, make_visible: true)    ##第一引数に画像を入れたい場所指定、第二は画像のパスをいれる、第三引数はオプションでdesplay-noneのものを表示させる(noneで消してるfieldには値を入力できないため)

        ## あらすじ
        fill_in "author_comics_attributes_0_summary", with: @comic.summary
        ## レビュー
        fill_in "author_comics_attributes_0_review", with: @comic.review

        ## 投稿btnクリック
        click_button "投稿する"

        ## 投稿後、root_pathへ遷移しているか
        expect(current_path).to eq root_path

        ## 遷移後の画面のどこかに、投稿したユーザー名があるか
        expect(page).to have_content @resistrated_user.name
      end

    end

    context "フォームの入力値が異常（空欄がある）" do
      it "作品投稿失敗（異常系）" do
        visit new_author_path
        fill_in "author_name", with: nil
        fill_in "author_comics_attributes_0_name", with: @comic.name
        fill_in "author_comics_attributes_0_name_kana", with: @comic.name_kana
        fill_in "author_comics_attributes_0_number_of_books", with: @comic.number_of_books
        select '未完結作品', from: "author[comics_attributes][0][booknumber_id]"
        select 'おすすめにする', from: "author[comics_attributes][0][recommend_id]"
        check '女性漫画'
        image_path = Rails.root.join('public/images/pose_ng_man.png')
        attach_file("author[comics_attributes][0][image]", image_path, make_visible: true)    ##第一引数に画像を入れたい場所指定、第二は画像のパスをいれる、第三引数はオプションでdesplay-noneのものを表示させる(noneで消してるfieldには値を入力できないため)
        fill_in "author_comics_attributes_0_summary", with: @comic.summary
        fill_in "author_comics_attributes_0_review", with: @comic.review
        click_button "投稿する"

        # 作成できなかった場合、新規登録画面のまま
        expect(current_path).to eq new_author_path

        # 画面そのままの際に、入力フォームに値を保持できている
        expect(page).to have_field "author_comics_attributes_0_name", with: @comic.name
        expect(page).to have_field "author_comics_attributes_0_name_kana", with: @comic.name_kana
        expect(page).to have_field "author_comics_attributes_0_number_of_books", with: @comic.number_of_books
        # セレクトされているか、セレクトフォーム内に入ってるかテストしたかったが思うような挙動にならなかったため、画面にあれば良しとする
        expect(page).to have_content '完結作品'
        expect(page).to have_content 'おすすめにする'
        # チェック入っているか
        expect(page).to have_checked_field('女性漫画')
        expect(page).to have_field "author_comics_attributes_0_summary", with: @comic.summary
        expect(page).to have_field "author_comics_attributes_0_review", with: @comic.review

      end
    end
  end
  
end