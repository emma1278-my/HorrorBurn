class ApplicationController < ActionController::Base
  helper_method :current_user
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      redirect_to login_path, danger: 'ログインしてください'
    end
  end

  def logged_in?
    !current_user.nil?
  end
end