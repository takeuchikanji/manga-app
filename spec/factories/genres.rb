FactoryBot.define do
  factory :genre do
    genre {Faker::Color.color_name}
  end
end