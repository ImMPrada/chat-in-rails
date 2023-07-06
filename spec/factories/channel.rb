FactoryBot.define do
  factory :channel do
    name { Faker::Internet.username(specifier: 3...20) }
    avatar_url { Faker::Internet.url }

    association :workspace
  end
end
