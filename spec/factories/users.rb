FactoryBot.define do
  factory :user do
    name {Faker::Book.author}      ##種類のないダミーデータだと確率でかぶってエラー出る、また今回だと11文字以上NGなので、11文字以上の名前が出た場合も正常系のテストでもエラーが出てしまうので注意
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
  end
end