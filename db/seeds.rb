# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


SeedDatabase.new.call
User.create(email: 'bruno@teste.com', password: '123456')

100.times do |i|
  User.create(email: "user#{i}@teste.com", password: '123456')
end

User.all.each do |user|
  Collection.new(user: user, name: 'My Collection', items_ids: sample_items).save
end

User.all.each do |user|
  WishList.new(user: user, name: 'My Wish List', items_ids: sample_items).save
end

def sample_items
  rand(0..1) == 0 ? Item.offset(rand(Item.count)).last(rand(1..100)).map(&:id)
                  : Item.offset(rand(Item.count)).first(rand(1..100)).map(&:id)
end

# recommender = ItemRecommender.new
# # Add a single course to topic-1's items. If topic-1 already exists as a set ID, this just adds course-1 to the set
# c = Category.all.sample
# recommender.add_to_matrix!(:categories, c.name, c.items.sample.id)
#  # license brand