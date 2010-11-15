
### Sessions Controller from restful_authentication (http://agilewebdevelopment.com/plugins/restful_authentication)
class SessionsController < ApplicationController

  #layout 'nonav'
  skip_before_filter :check_authentication

  def login
    @user = User.new
    return unless request.post?

    logger.ap '登录验证。。。'
    self.current_user = User.authenticate(params[:user][:login], params[:user][:password])
    if logged_in?
       logger.ap '登录成功!'
      if params[:remember_me] == '1'
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:notice] = 'Logged in.'
      redirect_to(home_path)
    else
      logger.ap '登录失败!'
      flash.now[:loginerror] = 'Authentication failed.'
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
