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
# CACHE.servers = '127.0.0.1:11211'
# config.action_controller.fragment_cache_store = CACHE, {}

# Initialize the rails application
Sill::Application.initialize!

require File.dirname(__FILE__) + '/../lib/database_version.rb'
DatabaseVersion.automatic_setup