require 'rails_helper'

RSpec.describe Request, type: :model do

  describe "作者名の登録機能テスト" do
    before do   
      @request = build(:request)
    end

    describe "要望送信成功（正常系）" do
      context "comicname,authorname,commentが存在するとき" do
        it "全て入力すると送信できる" do
          expect(@request).to be_valid
        end
      end

    end

    describe "要望送信失敗（異常系）" do
      context "comicname,authorname,commentのいずれかが存在しないとき" do
        it "comicnameが空だと登録できない" do
          @request.comicname = nil
          @request.valid?
          expect(@request.errors.full_messages).to include("Comicnameを入力してください")
        end

        it "authornameが空だと登録できない" do
          @request.authorname = nil
          @request.valid?
          expect(@request.errors.full_messages).to include("Authornameを入力してください")
        end

        it "commentが空だと登録できない" do
          @request.comment = nil
          @request.valid?
          expect(@request.errors.full_messages).to include("Commentを入力してください")
        end

        it "userのidが空だと保存できない" do
          @request.user = nil
          @request.valid?
          expect(@request.errors.full_messages).to include("Userを入力してください")
        end
      end
    end

  end

end