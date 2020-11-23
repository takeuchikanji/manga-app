FactoryBot.define do
  factory :request do
    comicname {Faker::Book.title}
    authorname {Faker::Book.author}
    comment {"衝撃の展開"}
    user

  end

end