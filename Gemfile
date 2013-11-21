source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0'

gem 'rack-timeout'
gem 'unicorn'

gem 'newrelic_rpm'

# Open-Source configuration management
gem "figaro"

# Github API gem
gem "octokit"

# Ruby OAuth gem
gem 'omniauth'
gem 'omniauth-github'

gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'uglifier', '>= 1.3.0'
gem 'therubyracer'

# Database
group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem "better_errors", "~> 1.0.1"
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'shoulda-matchers'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
