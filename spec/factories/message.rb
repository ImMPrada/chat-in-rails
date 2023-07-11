FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    classifiable { build(:workspace_channel) }
    author { build(:user) }
  end
end
