FactoryBot.define do
  factory :workspace_user do
    association :workspace
    association :user
    association :role
  end
end
