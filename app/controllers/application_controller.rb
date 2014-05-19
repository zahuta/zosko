class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_user
  helper_method :current_user

  def require_user
    if current_user
      true
    else
      redirect_to login_path
    end
  end

  def require_admin
    if current_user.admin
      true
    else
      redirect_to root_path
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
