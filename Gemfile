# frozen_string_literal: true

ruby '2.6.5'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

source 'https://rubygems.org' do
  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.2', '>= 5.2.4.6'
  # Use Postgres as the database for Active Record
  gem 'pg'
  # Use Puma as the app server
  gem 'puma', '~> 3.12'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.8', '>= 2.8.0'
  # Use Redis adapter to run Action Cable in production
  # gem 'redis', '~> 4.0'
  # Use ActiveModel has_secure_password
  gem 'bcrypt', '~> 3.1.7'

  # v1 api is [JSONAPI](https://jsonapi.org/)
  gem 'jsonapi-resources', '~> 0.10', '>= 0.10.2'

  # v2 api is [GraphQL](https://graphql.org/)
  gem 'graphql', '~> 1.7', '>= 1.7.14'

  # Use ActiveStorage variant
  # gem 'mini_magick', '~> 4.8'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development

  # Reduces boot times through caching; required in config/boot.rb
  gem 'bootsnap', '>= 1.1.0', require: false

  # Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making
  # cross-origin AJAX possible
  # gem 'rack-cors'

  # Geokit for distance information
  gem 'geokit-rails'

  group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger
    # console
    gem 'byebug', platforms: %i[mri mingw x64_mingw]
    gem 'database_cleaner', '~> 1.7', '>= 1.7.0'
    gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
    gem 'faker', '~> 1.9', '>= 1.9.1'
    gem 'rspec-graphql_matchers'
    gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
    gem 'shoulda-matchers', '~> 3.1', '>= 3.1.3'
  end

  group :development do
    gem 'listen', '>= 3.0.5', '< 3.2'
    gem 'rerun'
    gem 'rubocop'
    # Spring speeds up development by keeping your application running in the
    # background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.1'
    gem 'yard'
  end

  group :test do
    gem 'coveralls', require: false
    # gem 'simplecov', require: false
    gem 'timecop', '~> 0.9'
  end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
end
