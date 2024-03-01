# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
puts 'Starting...'

50.times do
  Seller.create!(name: Faker::Name.name)
end

puts "Created #{Seller.count} sellers"

50.times do
  Buyer.create!(name: Faker::Name.name)
end

puts "Created #{Buyer.count} buyers"

[
 :Apple,
 :Arrowroot,
 :Arugula,
 :Artichoke,
 :Asparagus,
 :Avocado,
 :Bamboo,
 :Banana,
 :Basil,
 :"Beet Root",
 :Blackberry,
 :Blueberry,
 :"Bok Choy",
 :Broccoli,
 :"Broccoli, Raab",
 :"Brussels sprouts",
 :Cabbage,
 :Cantaloupes,
 :Carrot,
 :Cauliflower,
 :Celery,
 :Chayote,
 :Chives,
 :Cilantro,
 :"Collard Greens",
 :Corn,
 :Cucumber,
 :Coconut,
 :Date,
 :Daikon,
 :Dill,
 :Eggplant,
 :Endive,
 :Fennel,
 :Fig,
 :"Garbanzo Bean",
 :Garlic,
 :Ginger,
 :Gourds,
 :Grape,
 :Guava,
 :Honeydew,
 :Horseradish,
 :"Iceberg Lettuce",
 :Jackfruit,
 :Jicama,
 :Kale,
 :Kangkong,
 :Kiwi,
 :Kohlrabi,
 :Leek,
 :Lentils,
 :"Lettuce, (see Iceberg Lettuce)",
 :Lychee,
 :Macadamia,
 :Mango,
 :Mushroom,
 :Mustard,
 :Nectarine,
 :Okra,
 :Onion,
 :Papaya,
 :Parsley,
 :"Parsley root",
 :Parsnip,
 :"Passion Fruit",
 :Peach,
 :Plum,
 :Peas,
 :Pear,
 :Peppers,
 :Persimmon,
 :Pimiento,
 :Pineapple,
 :Plum,
 :Pomegranate,
 :Potato,
 :Pumpkin,
 :Radicchio,
 :Radish,
 :Raspberry,
 :Rhubarb,
 :"Romaine Lettuce",
 :Rosemary,
 :Rutabaga,
 :Shallot,
 :Soybeans,
 :Spinach,
 :Squash,
 :Strawberries,
 :"Sweet potato",
 :"Swiss Chard",
 :Thyme,
 :Tomatillo,
 :Tomato,
 :Turnip,
 :Waterchestnut,
 :Watercress,
 :Watermelon,
 :Yams
].each do |produce_type|
  Produce.create!(
    produce_type:
  )
end

puts "Created #{Produce.count} produce items"

purchase = []
10000.times do
  purchase << {
    date_purchased: Faker::Time.between(from: 1.year.ago, to: Time.now),
    produce_id: Faker::Number.between(from: 1, to: 100),
    buyer_id: Faker::Number.between(from: 1, to: 50),
    seller_id: Faker::Number.between(from: 1, to: 50),
    status: [:cancelled, :completed].sample
  }
end
Purchase.upsert_all purchase

puts "Created #{Purchase.count} purchases"

puts "Seed complete"
