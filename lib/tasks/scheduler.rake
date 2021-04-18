desc 'This task is called by the Heroku scheduler add-on'
task get_items_from_funko: :environment do
  puts 'Getting items from Funko'
  SeedDatabase.new.call
  puts 'Added new items from Funko'
end
