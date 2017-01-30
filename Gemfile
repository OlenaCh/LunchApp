source 'https://rubygems.org'

gem 'rails', '4.2.6'

# PostgreSQL
gem 'pg', '~> 0.15'

# Authorization & Authentication
gem 'devise'
gem 'omniauth'
gem "omniauth-google-oauth2", "~> 0.2.1"

# Front end
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

# Pagination
gem 'will_paginate',           '3.1.0'

# Fake data
gem 'faker',                   '1.6.3'

# Uploading files
gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'
gem 'rmagick', :require => 'rmagick'

# Documentation
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'railroady'

group :development, :test do
  # Debugging
  gem 'byebug'
  
  # Smelly code detector
  gem 'reek'
  
  # ABC Complexity
  gem 'rails-flog', :require => "flog"
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'simplecov', :require => false
  gem 'database_cleaner', '1.4.1'
  gem 'capybara', '2.4.4'
  gem 'launchy'
  gem 'rspec-rails', '3.3.2'
  gem 'factory_girl_rails', '~> 4.0'
end