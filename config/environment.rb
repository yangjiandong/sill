# Load the rails application
require File.expand_path('../application', __FILE__)

# require 'memcache'

# memcache_options = {
# :c_threshold = 10_00,
# :compression = true,
# :debug = false,
# :namespace = 'yourappname_or_anything_you_like',
# :readonly = false,
# :urlencode = false
# }
# CACHE = MemCache.new(memcache_options)
# CACHE.servers = ['127.0.0.1:11211']
# config.action_controller.fragment_cache_store = CACHE, {}

 # Session Storage Configuration
#  session_options = {   :cache => CACHE,
#                        :session_key => '_bbsession',
#                        :session_domain => '.mysite.com',
#                        :session_expires => 3.months.from_now,
#                        :expires => 29.days }
#  config.action_controller.session_store = :mem_cache_store
#  ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.update(session_options)

# Initialize the rails application
Sill::Application.initialize!

require File.dirname(__FILE__) + '/../lib/database_version.rb'
DatabaseVersion.automatic_setup
