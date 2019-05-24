source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.3'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'mini_magick', '~> 4.8'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-postgresql-table'
gem 'ffaker'
gem 'pagy'
gem 'pundit'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'i18n'
gem 'devise'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'jquery-rails'
gem 'trix-rails', require: 'trix'
gem 'ancestry'
gem 'redis'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'simplecov', require: false, group: :test
  gem 'database_cleaner'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'fasterer'
  gem 'rubocop-rspec'
  gem 'rubocop-performance'
end


group :production do
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
