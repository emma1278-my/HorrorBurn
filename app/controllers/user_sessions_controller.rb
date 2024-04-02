class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    user = User.authenticate(params[:email], params[:password])

    if @user
      session[:user_id] = user.id
      redirect_back_or_to root_path, success: t('user_sessions.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, danger: t('user_sessions.destroy.success')
  end
end
  