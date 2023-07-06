FactoryBot.define do
  factory :workspace do
    name { Faker::Internet.username(specifier: 3...20) }
    avatar_url { Faker::Internet.url }
  end
end
