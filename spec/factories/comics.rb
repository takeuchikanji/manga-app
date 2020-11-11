FactoryBot.define do
  factory :comic do
    name {Faker::Book.title}
    name_kana {"あいうえお"}
    image {File.open("#{Rails.root}/public/images/pose_ng_man.png")}
    number_of_books {Faker::Number.between(from: 1, to: 100)}
    summary {"むかしむかし、あるところに"}
    review {"予想外の展開"}

    author
    booknumber
    recommend
  end
end