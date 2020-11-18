require 'rails_helper'

RSpec.describe "Authors", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)  ##元々、ユーザーを登録しておく(このユーザーに管理者権限を付与)
    @author = build(:author)        ##新しく登録したいユーザー
    @comic = build(:comic)
    @genre = build(:genre)

    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
  end

  describe "作品投稿" do
    context "フォームの入力値が正常" do
      it "作品投稿成功（正常系）" do

        visit new_author_path

        fill_in "author_name", with: @author.name
        fill_in "author_comics_attributes_0_name", with: @comic.name
        fill_in "author_comics_attributes_0_name_kana", with: @comic.name_kana
        fill_in "author_comics_attributes_0_number_of_books", with: @comic.number_of_books
        select '完結作品'
        select 'おすすめにする'
        check '女性漫画'
        # fill_in "author_comics_attributes_0_booknumber_id", with: @comic.booknumber_id
        # fill_in "author_comics_attributes_0_recommend_id", with: @comic.recommend_id
        # fill_in "author_comics_attributes_0_genre_ids_1", with: @genre.genre_ids_1    ##ジャンル
        # fill_in "author_comics_attributes_0_image", with: @comic.image

        image_path = Rails.root.join('public/images/pose_ng_man.png')
        attach_file("author[comics_attributes][0][image]", image_path, make_visible: true)    ##第一引数に画像を入れたい場所指定、第二は画像の保存してるファイルパスをいれる、第三引数のはオプションでdesplay-noneの物を表示させる
        fill_in "author_comics_attributes_0_summary", with: @comic.summary
        fill_in "author_comics_attributes_0_review", with: @comic.review

        click_button "投稿する"

        expect(current_path).to eq root_path

        expect(page).to have_content @resistrated_user.name
      end

    end
  end

end