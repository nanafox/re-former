100.times do
  password = Faker::Internet.password

  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email, password: password,
    password_confirmation: password,
  )
end
