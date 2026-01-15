# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# Users
100.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  dob = Faker::Date.birthday(min_age: 18, max_age: 100)

  user = User.create(
    first_name: first_name,
    last_name: last_name,
    dob: dob,
    email_address: "test@test.com"
  )

  user.update(
    email_address: user.first_name.downcase.gsub(/[^0-9a-z ]/i, '') + "_" + user.last_name.downcase.gsub(/[^0-9a-z ]/i, '') + "_" + user.id.to_s + "@gmail.com"
  )
end

# Genres
[ "Biography (NF)", "Cooking (NF)", "Fantasy", "Historical", "Horror", "Literary", "Memoir (NF)", "Mystery", "Romance", "Sci-Fi", "Self-Help (NF)", "Thriller", "True Crime (NF)" ].each do |genre_name|
  Genre.find_or_create_by!(name: genre_name)
end

# Books
1000.times do
  title = Faker::Book.title
  short_description = Faker::Lorem.paragraph

  Book.create(
    title: title,
    short_description: short_description
  )
end
