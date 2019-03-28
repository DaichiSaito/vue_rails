50.times do
  User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      age_id: Age.all.sample.id
  )
end
