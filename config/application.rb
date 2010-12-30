require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Define application specific global constants
$FLASHDIV = 'flashnotice'
$ADMINMODE = true     # Active Acl check is suspended for techusers with admin flag if this is true
$TIMEOUT = 10000      # Timeout for server requests
$GRIDHEIGHT = 600
$MENUTREEFILE = "config/menutree.xml"
$MYSQLTEXTSIZE = 65535
$DEFAULTLOGOIMAGE = "#{Rails.root}/public/images/homepage/ev-manager_logo.png"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Sill
  class Application < Rails::Application

    #http://garbageburrito.com/blog/entry/1326901/organizing-large-rails-projects-the-simple-way?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+garbageburrito-blog+%28Garbage+Burrito+-+Latest+Blog+Entries%29
    # ActionController::Base.view_paths.insert(1, "app/views/addons") add to lib/sill.rb
    # 有问题,没成功
    # config.autoload_paths += %W(
      # #{Rails.root.to_s}/app/controllers/addons
      # #{Rails.root.to_s}/app/models/addons
      # #{Rails.root.to_s}/app/helpers/addons
    # )
    # config.controller_paths += %W(
      # #{Rails.root.to_s}/app/controllers/addons
    # )

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    #
    # load lib/*.rb
    #config.autoload_paths += %W(#{config.root}/lib)
    #config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Have migrations with numeric prefix instead of UTC timestamp.
    # config.active_record.timestamped_migrations = false

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'#'UTC'#'Beijing'
    config.i18n.default_locale = 'en'#'zh_CN'

    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    # config.time_zone = nil

#    config.generators do |g|
#      g.template_engine :haml
#    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    if Rails.env.development?
      config.action_view.javascript_expansions[:jquery] = %w(jquery jquery.rails)
    else
      config.action_view.javascript_expansions[:jquery] = %w(jquery.min jquery.rails)
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.generators do |g|
      g.test_framework :rspec
    end

  end
end
