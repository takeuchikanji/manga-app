require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "コメントの投稿機能テスト" do
    before do   ##予め、設定しておく
      @comment = build(:comment)        ##コメント作成
    end

    describe "コメント投稿成功（正常系）" do
      
      it "textがあれば登録できる" do
        expect(@comment).to be_valid
      end

      it "textが100文字以内であれば投稿できる" do
        @comment.text = "あいうえおかきくけこ"
        expect(@comment).to be_valid
      end

    end

    describe "コメント投稿失敗（異常系）" do
      
      it "textが空だと投稿できない" do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textを入力してください")
      end

      it "user_idが無いと投稿できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end

      it "comic_idが無いと投稿できない" do
        @comment.comic = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Comicを入力してください")
      end

      it "textが101文字以上(101文字)だと投稿できない" do
        @comment.text = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffffgggggggggghhhhhhhhhhiiiiiiiiiijjjjjjjjjjk"
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textは100文字以内で入力してください")
      end
    end

  end

end