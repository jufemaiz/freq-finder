# frozen_string_literal: true

ruby '3.4.4'

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bundler', '~> 2.3', '>= 2.3.18'
gem 'csv'
gem 'json'
gem 'rexml', '~> 3.2', '>= 3.2.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0' # , '>= 5.2.8.1'
# Use Postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 6.6', '>= 6.6.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11', '>= 2.11.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1', '>= 3.1.18'

# v1 api is [JSONAPI](https://jsonapi.org/)
gem 'jsonapi-resources', '~> 0.10', '>= 0.10.7'

# v2 api is [GraphQL](https://graphql.org/)
gem 'graphql', '~> 2.5', '>= 2.5.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.18.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making
# cross-origin AJAX possible
# gem 'rack-cors'

# Geokit for distance information
gem 'geokit-rails', '~> 2.3'

# Net - ref: https://stackoverflow.com/questions/70500220/rails-7-ruby-3-1-loaderror-cannot-load-such-file-net-smtp.
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner', '~> 2.1', '>= 2.1.0'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.4'
  gem 'faker', '~> 3.5', '>= 3.5.1'
  gem 'rspec-rails', '~> 8.0'
  gem 'rubocop-factory_bot'
  gem 'rubocop-graphql'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'shoulda-matchers', '~> 6.5'
end

group :development do
  gem 'listen', '~> 3.9'
  gem 'rerun', '>= 0.13.1'
  gem 'rubocop', '~> 1.75'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
  gem 'yard'
end

group :test do
  gem 'coveralls', require: false
  # gem 'simplecov', require: false
  gem 'timecop', '~> 0.9'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
