source "https://rubygems.org"

ruby "3.4.8"

gem "rails", "~> 8.1.4"
gem "pg", "~> 1.7.0"
gem "puma", ">= 5.0"
gem "propshaft"
gem "dartsass-rails", "~> 0.5.1"
gem "bootstrap", "~> 5.3.8"
gem "bootsnap", require: false

# Lo schema di archimate include la vista materializzata search_items.
gem "scenic", "~> 1.9.0"

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "foreman", "~> 0.90.0", require: false
  gem "web-console"
end
