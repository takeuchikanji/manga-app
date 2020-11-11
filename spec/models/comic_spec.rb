require 'rails_helper'

RSpec.describe User, type: :model do

  describe "comic登録機能テスト" do
    before do   ##予め、設定しておく
      @comic = build(:comic)        ##新規投稿comic作成
    end

    describe "comic登録成功（正常系）" do
      context "name,name_kana,image,number_of_books,summary,reviewが存在するとき" do
        
        it "全て入力すると登録できる" do
          expect(@comic).to be_valid
        end

      end
    end

    describe "comic登録失敗（異常系）" do
      context "name,name_kana,image,number_of_books,summary,reviewのいずれかが存在しないとき" do
        
        it "nameが空だと保存できない" do
          @comic.name = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Nameを入力してください")
        end

        it "name_kanaが空だと保存できない" do
          @comic.name_kana = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Name kanaを入力してください")
        end

        it "imageが空だと保存できない" do
          @comic.image = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Imageを入力してください")
        end

        it "number_of_booksが空だと保存できない" do
          @comic.number_of_books = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Number of booksを入力してください")
        end

        it "summaryが空だと保存できない" do
          @comic.summary = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Summaryを入力してください")
        end

        it "reviewが空だと保存できない" do
          @comic.review = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Reviewを入力してください")
        end

        it "authorのidが空だと保存できない" do
          @comic.author = nil
          @comic.valid?
          expect(@comic.errors.full_messages).to include("Authorを入力してください")
        end

      end
    end
  end

end