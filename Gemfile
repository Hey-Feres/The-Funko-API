source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Devise is a flexible authentication solution for Rails based on Warden
gem 'devise'
# Simple, multi-client and secure token-based authentication for Rails
gem 'devise_token_auth'
# Pundit helps to build a simple, robust and scalable authorization system
gem 'pundit'
# ProgressBar is a simple Ruby library for displaying progress of long-running tasks on the console
gem 'progress_bar'
# Activerecord-Import is a library for bulk inserting data using ActiveRecord
gem 'activerecord-import'
# This gem is a C binding to the excellent YAJL JSON parsing and generation library
gem 'yajl-ruby', require: 'yajl'
# ActiveModelSerializers is undergoing some renovations
gem 'active_model_serializers'
# Fast and efficient recommendations and predictions using Ruby & Redis
gem 'predictor'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
