# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Only run on development (local) instances not on production, etc.
unless Rails.env.development?
  puts "Development seeds only (for now)!"
  exit 0
end

# Let's do this ...

## CATEGORIES

puts "Creating Users ..."

user1 = User.create!({
  first_name: 'Jimbo',
  last_name: 'Elbertson',
  email: 'jimbo@speedmail.com',
  password: 'tastycake', 
  password_confirmation: 'tastycake'
})
user2 = User.create!({
  first_name: 'Walnut',
  last_name: 'Collector',
  email: 'nuttyprofessor@nutsfornuts.com',
  password: 'walnutbutter',
  password_confirmation: 'walnutbutter'
})
user3 = User.create!({
  first_name: 'Eleanor',
  last_name: 'Hogglesworth',
  email: 'blueskyrain@homtail.com',
  password: 'ambivalence',
  password_confirmation: 'ambivalence'
})

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'

## PRODUCTS

puts "Re-creating Products ..."

Product.destroy_all

cat1.products.create!({
  name:  'Men\'s Classy shirt',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel1.jpg'),
  quantity: 10,
  price: 64.99
})

cat1.products.create!({
  name:  'Women\'s Zebra pants',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel2.jpg'),
  quantity: 18,
  price: 124.99
})

cat1.products.create!({
  name:  'Hipster Hat',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel3.jpg'),
  quantity: 4,
  price: 34.49
})

cat1.products.create!({
  name:  'Hipster Socks',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel4.jpg'),
  quantity: 8,
  price: 25.00
})

shoes = cat1.products.create!({
  name:  'Russian Spy Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel5.jpg'),
  quantity: 8,
  price: 1_225.00
})

cat1.products.create!({
  name:  'Human Feet Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel6.jpg'),
  quantity: 82,
  price: 224.50
})


cat2.products.create!({
  name:  'Modern Skateboards',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics1.jpg'),
  quantity: 40,
  price: 164.49
})

cat2.products.create!({
  name:  'Hotdog Slicer',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics2.jpg'),
  quantity: 3,
  price: 26.00
})

watch = cat2.products.create!({
  name:  'World\'s Largest Smartwatch',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics3.jpg'),
  quantity: 32,
  price: 2_026.29
})

cat3.products.create!({
  name:  'Optimal Sleeping Bed',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture1.jpg'),
  quantity: 320,
  price: 3_052.00
})

chair = cat3.products.create!({
  name:  'Electric Chair',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture2.jpg'),
  quantity: 2,
  price: 987.65
})

cat3.products.create!({
  name:  'Red Bookshelf',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture3.jpg'),
  quantity: 23,
  price: 2_483.75
})

puts "Creating Reviews ..."

shoes.reviews.create!({
  user_id: user1.id,
  rating: 4,
  description: "These shoes aren't shoes to let you become like a Russian spy, they are actually shoes that let Russians spy on you! Work very well though."
})

shoes.reviews.create!({
  user_id: user3.id,
  rating: 2,
  description: "Didn't fit me. :("
})

watch.reviews.create!({
  user_id: user2.id,
  rating: 5,
  description: "I can't feel my fingers anymore, but with this much functionality, who needs them?"
})

watch.reviews.create!({
  user_id: user1.id,
  rating: 4,
  description: "It keeps rolling around my wrist when I use it, but just watching those vibrant colours go round is enough for me."
})

chair.reviews.create!({
  user_id: user3.id,
  rating: 1,
  description: "Shockingly bad!!!"
})

puts "DONE!"
