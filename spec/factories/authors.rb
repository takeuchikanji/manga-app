FactoryBot.define do
  factory :author do
    name {Faker::Book.author}

  end

  # factory :author_with_comic
end

