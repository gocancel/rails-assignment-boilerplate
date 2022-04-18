source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# gem 'bcrypt', '~> 3.1.7'
gem 'cssbundling-rails', '~> 0.2.6'
gem 'has_scope', '~> 0.8.0'
gem 'jsbundling-rails', '~> 0.2.0'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'sass-rails', '>= 6'
gem 'sqlite3', '~> 1.4'
gem 'turbo-rails', '~> 0.9.0'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.1'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'foreman', '~> 0.87.2'
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
