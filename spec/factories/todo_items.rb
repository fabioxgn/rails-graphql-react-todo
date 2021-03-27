FactoryBot.define do
  factory :todo_item do
    description { Faker::Lorem.sentence }
  end
end