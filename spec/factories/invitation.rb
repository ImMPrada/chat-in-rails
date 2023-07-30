FactoryBot.define do
  factory :invitation do
    token { SecureRandom.hex(10) }

    association :workspace
    association :receiver, factory: :user
  end
end
