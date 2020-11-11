require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "ユーザーの新規登録機能" do
    before do   ##予め、設定しておく
      @resistrated_user = create(:user)   ##ユーザー作成
      @user = build(:user)        ##2人目
    end

    describe "ユーザー登録成功（正常系）" do
      context "name,email,password,password_confirmationが存在するとき" do

        it "passwordが6文字以上であれば登録できる" do
          expect(@user).to be_valid
        end

        it "パスが使用済でも登録できる" do    ##AさんとBさんが同じパスワードでも問題ない
          @user.password = @resistrated_user.password
          @user.password_confirmation = @user.password
          expect(@user).to be_valid
        end

      end
    end

    describe "ユーザー登録失敗（異常系）" do
      context "name,email,password,password_confirmationのいずれかが存在しないとき" do
        
        it "nameが空だと登録できない" do
          @user.name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームを入力してください", "ニックネームは2文字以上で入力してください")
        end

        it "emailが空だと登録できない" do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end

        it "passwordが空だと登録できない" do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end

        ##deviseの仕様で、password_confirmationは空でも登録できます→→ただ、passwordとセットでないと登録ができないので、そのテスト(パスと再度パス2つが一致しているか揃ってるか)を行う必要がある↓↓↓下でテストしてる
      end

      context "name,email,passwordが存在するとき" do
      
        it "nameがすでに使用されていると登録できない" do
          @user.name = @resistrated_user.name
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームはすでに存在します")
        end

        it "nameが1文字だと登録できない" do
          @user.name = "あ"
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームは2文字以上で入力してください")
        end

        it "nameが11文字以上だと登録できない" do
          @user.name = "あああああああああああ"
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームは10文字以内で入力してください")
        end

        it "emailがすでに使用されていると登録できない" do
          @user.email = @resistrated_user.email
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールはすでに存在します")
        end

        it "emailの中に@マークがないと登録できない" do
          @user.email = "aaaexample.com"
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールは不正な値です")
        end

        it "passwordが6文字未満だと登録できない" do
          @user.password = "12345"
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
        end

        it "passwordとpassword_confirmationが一致していない場合、登録できない" do
          @user.password_confirmation = "123456"
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end

      end
    end

  end
end