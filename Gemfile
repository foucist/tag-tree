source 'https://rubygems.org'
#ruby "1.9.3"

gem 'rails', '3.2.9'

group :production, :staging do
  gem "pg"
end

group :development, :test do
  gem 'sqlite3'
end

gem 'acts-as-taggable-on'
gem 'haml'
gem 'thin'

gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

