source 'https://rubygems.org'

ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.3'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Newrelic /newrelic
gem 'newrelic_rpm'

# HAML
gem 'haml'
gem 'haml-rails'

# ENV var management
gem 'figaro'

# Forms
gem 'simple_form'

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'quiet_assets'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  # code coverage
  gem 'simplecov'
  gem 'coveralls'
end

group :development, :test do
  # App preloading
  gem 'spring'
  gem 'spring-commands-rspec'
  # Pry stuff
  gem 'pry'
  gem 'pry-coolline'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'hirb'
end
