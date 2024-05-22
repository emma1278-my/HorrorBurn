class ApplicationController < ActionController::Base
  before_action :require_login
  
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # ログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  private

  def not_authenticated
    redirect_to login_path, danger: t('application.not_authenticated')
  end
end