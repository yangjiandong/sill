
### Sessions Controller from restful_authentication (http://agilewebdevelopment.com/plugins/restful_authentication)
class SessionsController < ApplicationController

  layout 'nonav'
  skip_before_filter :check_authentication
  
  def login
    return unless request.post?
    
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == '1'
        data_cache('remember_me_login_info'){'about,app_login_info,ok...'}

        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:notice] = '登录成功!'
      data_cache('app_login_info'){'about,app_login_info,ok...'}
      redirect_to(home_path)
    else
      flash.now[:loginerror] = '验证失败 :-('
    end
  end

  def logout
    if logged_in?
      self.current_user.on_logout
      self.current_user.forget_me
    end
    cookies.delete :auth_token    
    flash[:notice]='You have been logged out.'
    redirect_to(home_path)
    reset_session
  end

end

