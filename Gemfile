source "https://rubygems.org"

gemspec

group :develop do
end

group :debug do
  gem 'psych', :platforms => [:mri, :rbx]
  gem "wirble"
  gem "redcarpet", :platforms => :ruby
  gem "debugger", :platforms => :mri_19
  gem "byebug", :platforms => :mri
  gem "ruby-debug", :platforms => :jruby
  gem "pry", :platforms => :rbx
  gem 'guard-rspec'
end

group :test do
  gem "rspec"
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubinius', '~> 2.0'
end
