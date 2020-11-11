require 'rails_helper'

RSpec.describe User, type: :model do

  describe "作者名の登録機能テスト" do
    before do   ##予め、設定しておく
      @author = build(:author)        ##作者名作成
    end

    describe "作者名登録成功（正常系）" do
      
      it "nameがあれば登録できる" do
        expect(@author).to be_valid
      end

    end

    describe "登録失敗（異常系）" do
      
      it "nameが空だと登録できない" do
        @author.name = nil
        @author.valid?
        expect(@author.errors.full_messages).to include("Nameを入力してください")
      end
    end
    
  end

end