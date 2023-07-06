FactoryBot.define do
  factory :role do
    name { %w[owner admin member].sample }
  end
end
