# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
@seed_start = Time.now

def running_time
  "#{(Time.now - @seed_start).seconds.round(2)}s"
end
# Users
100.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  dob = Faker::Date.birthday(min_age: 18, max_age: 100)
  email = "#{first_name.downcase.gsub(/[^0-9a-z ]/i, '')}_#{last_name.downcase.gsub(/[^0-9a-z ]/i, '')}_#{i}@gmail.com"

  User.create(
    first_name: first_name,
    last_name: last_name,
    dob: dob,
    email_address: email
  )
end

puts "Users complete -- #{running_time}"

# Genres
[ "Biography (NF)", "Cooking (NF)", "Fantasy", "Historical", "Horror", "Literary", "Memoir (NF)", "Mystery", "Romance", "Sci-Fi", "Self-Help (NF)", "Thriller", "True Crime (NF)" ].each do |genre_name|
  Genre.find_or_create_by!(name: genre_name)
end

genres = Genre.all

puts "Genres complete -- #{running_time}"
# Books
1000.times do
  title = Faker::Book.title
  short_description = Faker::Lorem.paragraph
  user = User.all.sample(1)

  book = Book.create(
    title: title,
    short_description: short_description,
    user_id: user.first.id,
  )

  book.cover.attach(
    io:  File.open(File.join(Rails.root, 'app/assets/images/dummy_cover.jpg')),
      filename: 'dummy_cover.jpg'
  )

  book.body.attach(
    io:  File.open(File.join(Rails.root, 'app/assets/images/dummy_body.pdf')),
      filename: 'dummy_body.pdf'
  )

  genres.sample(rand(1..3)).each do |genre|
    BookGenre.create(book: book, genre: genre)
  end

  # book.genres << genres.sample(2)
end

puts "Books complete -- #{running_time}"
