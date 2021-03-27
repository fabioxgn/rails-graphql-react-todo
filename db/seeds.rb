5.times do 
  TodoItem.create!(description: Faker::Lorem.sentence)
end