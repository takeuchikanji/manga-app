# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "管理者",
             email: "admin@admin.com",
             password:  "12345678",
             password_confirmation: "12345678",
             admin: true)

Genre.create!(
  [
    { genre: '女性漫画' },
    { genre: '少女漫画' },
    {genre: '青年漫画' },
    {genre: '少年漫画' },
    {genre: 'TL漫画' },
    {genre: 'BL漫画' },
    {genre: 'オトナ漫画' },
    {genre: '恋愛' },
    {genre: 'ヒューマンドラマ' },
    {genre: 'ギャグ・コメディー' },
    {genre: '職業・ビジネス' },
    {genre: 'サスペンス・ミステリー' },
    {genre: '歴史・時代劇' },
    {genre: 'スポーツ' },
    {genre: 'アクション・アドベンチャー' },
    {genre: 'ホラー' },
    {genre: 'SF・ファンタジー' },
    {genre: 'グルメ' },
    {genre: '医療・病院系' },
    {genre: 'メカ' },
    {genre: '日常系' },
    {genre: 'バトル' },
    {genre: 'ラノベ原作' }
  ]
)