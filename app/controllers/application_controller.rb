class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :authenticated?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticated?
    current_user.present?
  end

  def authenticate!
    unless authenticated?
      flash[:error] = "You must be logged in to access this resource."
      redirect_to auth_login_path
    end
  end
end
