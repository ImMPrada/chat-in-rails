FactoryBot.define do
  factory :workspace_channel_user do
    association :workspace_channel
    association :user
  end
end
