# Load the rails application
require File.expand_path('../application', __FILE__)
require 'dalli'

memcache_options = {
 :compress => true,
 :namespace => 'yourappname_or_anything_you_like',
 # :expires_in => 1.day,
}

memcache_servers = ['127.0.0.1:11211']
begin
  # CACHE = MemCache.new  memcache_servers, memcache_options
  APP_CACHE = Dalli::Client.new memcache_servers, memcache_options
rescue Exception => e
  Rails.log e.message
  debug_log 'no memecached server'
end

#  session_options = {   :cache => CACHE,
#                        :session_key => '_bbsession',
#                        :session_domain => '.mysite.com',
#                        :session_expires => 3.months.from_now,
#                        :expires => 29.days }
#  config.action_controller.session_store = :mem_cache_store
#  ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.update(session_options)

# Initialize the rails application
Sill::Application.initialize!

# clear rails cache,if use filecache,it dele tmp/cache/**
Rails.cache.clear

#jammit
#config.gem "jammit"

require File.dirname(__FILE__) + '/../lib/database_version.rb'
DatabaseVersion.automatic_setup
