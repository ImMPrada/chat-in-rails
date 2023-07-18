FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    classifiable { build(:channel) }
    author { build(:user) }
  end
end
