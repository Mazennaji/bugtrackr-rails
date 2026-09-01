source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "image_processing", "~> 1.2"

gem "jwt"
gem "dotenv-rails"
gem "bcrypt"
gem "redis"
gem "ransack"
gem "fiddle"

gem "rswag-api"
gem "rswag-ui"
gem "rswag-specs", group: :test

group :development, :test do
  gem "rspec-rails"
  gem "debug", ">= 1.11", platforms: %i[mri windows], require: false
end

group :tools do
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "bundler-audit", require: false
end