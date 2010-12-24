source 'http://rubygems.org'

gem 'rails', '3.0.1'
if defined?(JRUBY_VERSION)
    # gem 'jdbc-sqlite3'
    gem 'activerecord-jdbc-adapter'
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcmssql-adapter'
    gem 'jruby-openssl'
    gem 'jruby-rack'
else
    gem 'sqlite3-ruby', :require => 'sqlite3'
end

gem 'haml'
gem 'will_paginate',        '>= 3.0.pre2'

# format log
gem 'awesome_print',      '>= 0.2.1'

group :development do
   gem 'annotate',           '>= 2.4.0'
   gem 'ffaker',             '>= 0.4.0' # Fast Faker for `rake crm:demo:load`
   gem 'rails3-generators'
   gem 'warbler'
   gem 'bullet'
   gem 'mongrel'

end

gem 'yaml_db'
gem 'uuidtools'
gem 'fastercsv'

gem 'dalli'
#background job
gem 'delayed_job'

group :test do
  gem 'rspec-rails', '>= 2.0.1'
  gem 'autotest'
  gem 'webrat'
  gem 'capybara'
end
