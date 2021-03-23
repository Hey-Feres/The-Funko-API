# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
data = JSON.load(File.open("#{Rails.root}/public/official_pop_data.json"))

# Categories
puts 'Creating Categories'
categories = data.map{ |data| data['category'] }.uniq
categories.each do |category|
  Category.create!(name: category)
end
# Events
puts 'Creating Events'
events = data.map{ |data| data['events'] }.uniq
events.delete(nil)
events = events.map{|data| data.split(',')}.flatten.uniq
events.each do |event|
  Event.create!(name: event)
end
# License
puts 'Creating Licenses'
licenses = data.map{ |data| data['license'] }.uniq
licenses.each do |license|
  License.create!(name: license)
end
# Brand
puts 'Creating Brands'
brands = data.map{ |data| data['brand'] }.uniq
brands.each do |brand|
  Brand.create!(name: brand)
end
# Features
puts 'Creating Features'
features = data.map{ |data| data['features'] }.uniq
features.delete(nil)
features.each do |feature|
  Feature.create!(name: feature)
end

puts 'Creating Items'
data[1..-1].each do |data|
  item = Item.new(
    number: data['item-number'],
    title: data['title'],
    form_factor: data['form-factor'],
    inner_case_count: data['inner-case-count'],
    master_case_quantity: data['master-case-quantity'],
    status: data['status'],
    image_url: data['image-url']
  )
  #
  item.category = Category.find_by(name: data['category'])
  item.license  = License.find_by(name: data['license'])
  item.brand    = Brand.find_by(name: data['brand'])
  #
  if data['events'].present?
    data['events'].split(',').each do |event_name|
      event = Event.find_by(name: event_name)

      if event.present?
        item.events << event if item.events.map(&:id).exclude?(event.id)
      end
    end
  end
  #
  if data['features'].present?
    data['features'].split(',').each do |feature_name|
      feature = Feature.find_by(name: feature_name)

      if feature.present?
        item.features << feature if item.features.map(&:id).exclude?(feature.id)
      end
    end
  end
  #
  item.save!
end
