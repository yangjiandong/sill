require "sill/version"
require "sill/core_ext"
require "sill/callback"

      ActionView::Base.send(:include, Sill::Callback::Helper)
ActionController::Base.send(:include, Sill::Callback::Helper)