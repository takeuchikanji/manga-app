require 'rails_helper'

RSpec.describe "Requests", type: :system do
  before do
    @resistrated_user = create(:user, admin: true)
    visit new_user_session_path
    fill_in "user_email", with: @resistrated_user.email
    fill_in "user_password", with: @resistrated_user.password
    click_button "ログインする"
    @request = build(:request)
  end

  describe "要望送信機能" do

    it "要望送信ページなのか" do
      # 要望送信ページへ遷移
      visit new_user_request_path(@resistrated_user)
      expect(page).to have_content "要望フォーム"
    end

    context "フォームの入力値が正常" do
      it "要望送信成功（正常系）" do

        visit new_user_request_path(@resistrated_user)

        ## 作品名入力
        fill_in "request_comicname", with: "まんが"
        ## 作者名入力
        fill_in "request_authorname", with: "作者"
        ## おすすめポイント入力
        fill_in "request_comment", with: "おすすめ"
        
        ## 投稿btnクリック
        click_button "送信する"

        ## 投稿後、root_pathへ遷移しているか
        expect(current_path).to eq root_path

        ## 遷移後の画面のどこかに、投稿したユーザー名があるか
        expect(page).to have_content @resistrated_user.name
      end
    end

    context "フォームの入力値が異常（空）" do
      it "要望送信失敗（異常系）" do

        visit new_user_request_path(@resistrated_user)

        ## 作品名を空で送信
        fill_in "request_comicname", with: nil
        fill_in "request_authorname", with: "作者"
        fill_in "request_comment", with: "おすすめ"

        click_button "送信する"

        ## 画面そのまま
        expect(current_path).to eq new_user_request_path(@resistrated_user)

        ## 値を維持できているか
        expect(page).to have_field "request_authorname", with: "作者"
        expect(page).to have_field "request_comment", with: "おすすめ"
      end
    end
  end


  describe "要望を削除する(管理者が削除)" do
    it "要望詳細ページから削除ができる" do
      # 事前に要望を出しておく
      @resistrated_request = create(:request)

      # 詳細画面へ遷移
      visit user_request_path(@resistrated_user, @resistrated_request.id)
      expect(page).to have_content @resistrated_request.comicname

      click_link "削除する"     ## valueが"削除する"のとこをクリック
      expect {
        page.accept_confirm "紹介依頼を削除しますか？"    ## ダイアログを許可する（引数にダイアログの内容を書く）
        expect(page).to have_content "削除しました"
      }.to change{ Request.count }.by(-1)
      expect(current_path).to eq root_path
    end
  end
end