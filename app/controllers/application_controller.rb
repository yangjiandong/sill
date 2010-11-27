#

class ApplicationController < ActionController::Base

  # TODO
  include AuthenticatedSystem
  include NeedAuthorization::Helper

  before_filter :check_database_version, :check_authentication

  def self.root_context
    #ActionController::Base.relative_url_root || ''
    ''
  end

  def java_facade
    @java_facade ||= Java::OrgSonarServerUi::JRubyFacade.new
  end

  # Filter method to enforce a resource.
  #
  # To require resource for all actions, use this in your controllers:
  #
  #   before_filter :resource_required
  #
  # To require resourcess for specific actions, use this in your controllers:
  #
  #   before_filter :resource_required, :only => [ :edit, :update ]
  #
  # To skip this in a subclassed controller:
  #
  #   skip_before_filter :resource_required
  #
  #
  # Mandatory parameter : 'resource' or 'id'
  #
  # After filter is executed :
  #   @resource is the current resource.
  #   @resource.project is the current project
  #
  #
  def resource_required
    key=params[:resource] || params[:id]
    @resource=Project.by_key(key) if key
    redirect_to_default unless @resource
  end

  protected

  def check_database_version
    unless DatabaseVersion.uptodate?
      redirect_to :controller => 'maintenance', :action => 'index'
    end
  end

  # Do not log common errors like 404.
  # See http://maintainable.com/articles/rails_logging_tips
  EXCEPTIONS_NOT_LOGGED = ['ActionController::UnknownAction','ActionController::RoutingError']
  def log_error(exc)
    super unless EXCEPTIONS_NOT_LOGGED.include?(exc.class.name)
  end

  def check_authentication
    if current_user.nil?
      #&& Property.value('sonar.forceAuthentication')=='true'
      return access_denied
    end
  end

  private

  # memcached
  # http://www.ridingtheclutch.com/2009/01/08/cache-anything-easily-with-rails-and-memcached.html
  def data_cache(key)
    unless output = CACHE.get(key)
      output = yield
      CACHE.set(key, output, 1.hour)
    end
    return output
  end

  # example
  # result = data_cache('foo') {'Hello,wolrd!'}
  # md5 = Digest::MD5.hexdigest(request.request_uri)
  # output = data_cache(md5) { SEARCH.search(keywords, options) }

end
