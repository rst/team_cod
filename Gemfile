source 'https://rubygems.org'
ruby '2.2.2'
gem 'rails', '~> 4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end
gem 'bootstrap-sass'
gem 'devise'
gem 'pg'
gem 'puma'
gem 'sendgrid'
gem 'therubyracer', :platform=>:ruby
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'quiet_assets'
  gem 'rails_layout'
end
gem 'rails_12factor', group: :production

# We're not using indeed-ruby, but there's dummy query code in app/models,
# which gets loaded in production, so to keep that from blowing up
# on a failed 'require', we need this in the Gemfile.

gem 'indeed-ruby'
