require 'rails_helper'

RSpec.describe Genre, type: :model do

  describe "ジャンルの登録機能テスト" do
    before do   ##予め、設定しておく
      @resistrated_genre = create(:genre)   ##予め、ジャンルを作っておく（被りのテストで使う）
      @genre = build(:genre)        ##ジャンル作成（アプリ自体のgenreはnewアクションで登録じゃなく、seedファイルに予め記述している）
    end

    describe "ジャンル登録成功（正常系）" do
      
      it "genreがあれば登録できる" do
        expect(@genre).to be_valid
      end

    end

    describe "登録失敗（異常系）" do
      
      it "nameが空だと登録できない" do
        @genre.genre = nil
        @genre.valid?
        expect(@genre.errors.full_messages).to include("Genreを入力してください")
      end

      it "同じgenreがすでに登録済の場合、登録できない" do
        @genre.genre = @resistrated_genre.genre
        @genre.valid?
        expect(@genre.errors.full_messages).to include("Genreはすでに存在します")
      end
    end
    
  end

end