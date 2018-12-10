FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence(10) }
    user
  end
end
