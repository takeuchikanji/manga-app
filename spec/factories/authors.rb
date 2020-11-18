FactoryBot.define do
  factory :author do
    name {Faker::Book.author}

    ## 追加のオプション
    # author, :with_comicsで実行するとtrait内の記述も実行される
    # trait :with_comics do       ## comic：genre = 多：多 
    #   after(:create) do |author|
    #     create_list(:comic, 1, comics: author)
    #   end
    # end


  end

end

