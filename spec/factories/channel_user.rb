FactoryBot.define do
  factory :channel_user do
    association :channel
    association :user
  end
end
