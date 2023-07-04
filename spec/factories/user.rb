FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 3...20) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
