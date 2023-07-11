FactoryBot.define do
  factory :workspace_channel do
    name { Faker::Internet.username(specifier: 3...20).gsub(/[^a-zA-Z0-9_-]/, '') }
    avatar_url { Faker::Internet.url }

    association :workspace
  end
end
