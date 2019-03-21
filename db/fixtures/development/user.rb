50.times do
  User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      age: [*18..29].sample
  )
end
