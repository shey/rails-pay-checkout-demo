source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "standard"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

###################################################################
## payments ✓
####################################################################
gem "pay", "~> 7.1.1"
gem "receipts", "~> 2.0"
gem "stripe", "~> 10.12"
gem "pg", "~> 1.5"
gem "faker", "~> 3.3"
