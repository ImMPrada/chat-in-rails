FactoryBot.define do
  factory :workspace do
    name { Faker::Internet.username(specifier: 3...20).capitalize.gsub(/[^a-zA-Z]/, '') }
    avatar_url { Faker::Internet.url }
  end
end
