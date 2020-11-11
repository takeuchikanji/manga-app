FactoryBot.define do
  factory :comic do
    name {Faker::Book.title}
    name_kana {"あいうえお"}
    image {File.open("#{Rails.root}/public/images/pose_ng_man.png")}
    number_of_books {Faker::Number.between(from: 1, to: 100)}
    summary {"むかしむかし、あるところに"}
    review {"衝撃の展開"}
    author
    
  end
end