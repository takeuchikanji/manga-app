FactoryBot.define do
  factory :comic_genre do
    comic
    genre
    ## 中間テーブル作成 => 多対多の関係でテストしたい場合（editとかで作品のジャンル持たせるとか）、
    ## テストコードでcreateするときに、FactoryBot.create(:comic_genre) と書くだけで（実際はFactoryBotも略せるようにしてる）、
    ## comicsテーブルにid:1のcomic、genresテーブルにid:1のgenreを作成することができる
    ## 実際、@comic_genre = create(:comic_genre) => @comic_genre.comicとかで作品を取得できるようになる
  end
end
