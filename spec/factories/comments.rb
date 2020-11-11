FactoryBot.define do
  factory :comment do
    text {Faker::Color.color_name}
    user
    comic
  end
end