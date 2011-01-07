#

class ApplicationHtmlController < ActionController::Base
  helper :all
  layout 'application_html'

  private

  def check_authentication
    if current_user.nil? && Property.value('sill.forceAuthentication')=='true'
      return access_denied
    end
  end

end
