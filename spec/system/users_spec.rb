require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @resistrated_user = create(:user)  ##元々、ユーザーを登録しておく
    @user = build(:user)        ##新しく登録したいユーザー
  end

  describe "ログイン前" do

    describe "ユーザー新規登録" do

      context "フォームの入力値が正常" do
        it "ユーザー新規作成成功（正常系）" do
          ## 新規登録画面開く
          visit new_user_registration_path

          ## フォームに入力する（inputタグのidを第一引数にいれる）
          fill_in "user_name", with: @user.name
          fill_in "user_email", with: @user.email
          fill_in "user_password", with: @user.password
          fill_in "user_password_confirmation", with: @user.password_confirmation

          ## 登録btn押す
          click_button "アカウントを作成する"

          ## 新規登録後、root_pathへ遷移することを期待
          expect(current_path).to eq root_path

          ## 登録完了したら、rootに戻るがトップページの右上にユーザー名が表示されてるかテスト
          expect(page).to have_content @user.name
        end
      end

      context "フォームの入力値が異常（パスが空白）" do     ##空だととか一意性だとかは、単体テストチェックしたので、ここではエラーだった際に思い通りの挙動を取れるかをテスト
        it "ユーザー新規作成失敗（異常系）" do
          visit new_user_registration_path
          fill_in "user_name", with: @user.name
          fill_in "user_email", with: @user.email
          fill_in "user_password", with: nil
          fill_in "user_password_confirmation", with: @user.password_confirmation

          click_button "アカウントを作成する"

          ## 作成できなかった場合、新規登録画面のまま
          expect(current_path).to eq new_user_registration_path

          ## 画面そのままの際に、入力フォームに値を保持できている
          expect(page).to have_field "user_name", with: @user.name
          expect(page).to have_field "user_email", with: @user.email

        end
      end

    end
  end

  
  describe "ログインをする" do
    
    context "フォームの入力値正常" do
      it "ログイン成功（正常系）" do
        ## ログイン画面へ遷移
        visit new_user_session_path

        ## ログイン情報入力
        fill_in "user_email", with: @resistrated_user.email
        fill_in "user_password", with: @resistrated_user.password

        ## ログインbtn押す
        click_button "ログインする"
        ## ログイン後、root_pathへ遷移することを期待
        expect(current_path).to eq root_path

        ## ログイン完了したら、rootに戻るがトップページの右上にユーザー名が表示されてるかテスト
        expect(page).to have_content @resistrated_user.name
      end
    end

    context "フォームの入力値異常" do
      it "ログイン失敗（異常系）" do
        ## ログイン画面へ遷移
        visit new_user_session_path

        ## ログイン情報入力
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: nil

        ## ログインbtn押す
        click_button "ログインする"
        ## ログイン失敗の場合、画面そのまま
        expect(current_path).to eq new_user_session_path

        ## 画面そのままの際に、入力フォームに値を保持できている
        expect(page).to have_field "user_email", with: @user.email
      end
    end
  end


  describe "ログイン後" do
    
    describe "ユーザー情報編集" do
      
      context "フォームの入力値が正常" do
        it "ユーザー情報編集成功（正常系）" do
          ## 編集するにはログインの必要あるため、ログインしておく
          visit new_user_session_path
          fill_in "user_email", with: @resistrated_user.email
          fill_in "user_password", with: @resistrated_user.password
          click_button "ログインする"

          ## 編集画面へ遷移
          visit edit_user_registration_path

          ## 編集画面で、現在の名前とメールアドレスの値が既にフォームに入力済み
          expect(page).to have_field "user_name", with: @resistrated_user.name
          expect(page).to have_field "user_email", with: @resistrated_user.email

          ## ユーザー情報を変更する
          fill_in "user_name", with: "あいうえお"
          fill_in "user_email", with: "abcde@example.com"
          fill_in "user_password", with: "12345678"
          fill_in "user_password_confirmation", with: "12345678"
          fill_in "user_current_password", with: @resistrated_user.password

          ## 変更btn押す
          click_button "変更する"

          ## 編集後、root_pathへ遷移することを期待
          expect(current_path).to eq root_path

          ## 編集後、rootに戻るがトップページの右上にユーザー名が表示されてるかテスト、変更後のnameになっているか
          expect(page).to have_content "あいうえお"
        end
      end

      context "フォームの入力値が異常" do
        it "ユーザー情報編集失敗（異常系）" do
          ## 編集するにはログインの必要あるため、ログインしておく
          visit new_user_session_path
          fill_in "user_email", with: @resistrated_user.email
          fill_in "user_password", with: @resistrated_user.password
          click_button "ログインする"

          ## 編集画面へ遷移
          visit edit_user_registration_path

          ## 編集画面で、現在の名前とメールアドレスの値が既にフォームに入力済み
          expect(page).to have_field "user_name", with: @resistrated_user.name
          expect(page).to have_field "user_email", with: @resistrated_user.email

          ## ユーザー情報を変更する
          fill_in "user_name", with: "あいうえお"
          fill_in "user_email", with: "abcde@example.com"
          fill_in "user_password", with: "12345678"
          fill_in "user_password_confirmation", with: "12345678"
          fill_in "user_current_password", with: nil

          ## 変更btn押す
          click_button "変更する"

          ## 失敗時、画面そのまま
          expect(current_path).to eq edit_user_registration_path

          ## 失敗時、変更後の値を保持できているか
          expect(page).to have_field "user_name", with: "あいうえお"
          expect(page).to have_field "user_email", with: "abcde@example.com"
        end
      end

    end
  end
end
