source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

# =================Include gem ================
# Include boostrap an font Awesome
gem "bootstrap-sass", "3.3.6"
gem "font-awesome-rails"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
gem "config"
# Gem create data demo
gem "faker", "~> 1.7", ">= 1.7.3"
# Gem create pagination
gem "will_paginate","3.1.0"
gem "will_paginate-bootstrap"
gem "carrierwave", "0.11.2"
gem "mini_magick", "4.5.1"
gem "pry", "~> 0.10.4"
gem 'whenever'
gem 'friendly_id', '~> 5.2', '>= 5.2.1'

group :development, :test do
  # Use mysql data
  gem "sqlite3", "1.3.12"
  gem "byebug", platform: :mri
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.8"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg", "0.18.4"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
