# require "sill/version"
# require "sill/core_ext"
# require "sill/callback"
require "authenticated_system"
require "need_authorization"
require "need_authentication"
#require "slf4j_logger"
require "debug_log"

# 
require "enum_attr"
Object.send :include, EnumAttr::Mixin

      # ActionView::Base.send(:include, Sill::Callback::Helper)
# ActionController::Base.send(:include, Sill::Callback::Helper)

#ActionController::Base.view_paths.insert(1, "app/views/addons")
ActionController::Base.send(:include, DebugLog)
ActiveRecord::Base.send(:include, DebugLog)

