FactoryBot.define do
  factory :comic do
    name {Faker::Book.title}
    name_kana {"あいうえお"}
    image {File.open("#{Rails.root}/public/images/pose_ng_man.png")}
    number_of_books {Faker::Number.between(from: 1, to: 100)}
    summary {"むかしむかし、あるところに"}
    review {"衝撃の展開"}

    booknumber_id {1}
    recommend_id {1}

    author
    

    # trait :with_genres do       ## comic：genre = 多：多 
    #   after(:create) do |comic|
    #     create_list(:genre, 1, comics: [comic])
    #   end
    # end

    # trait :abc do
    #   booknumber_id {1}
    #   recommend_id {1}
    # end
  end
end