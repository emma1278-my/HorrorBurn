class UserSessionsController < ApplicationController
  skip_before_action :require_login
 
  def new; end

  def create
     @user = login(params[:email], params[:password])
    if @user
      flash[:success] = t(".success")
      redirect_to dashboard_path(current_user)
    else
      flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:danger] = t('user_sessions.destroy.success')
    redirect_to root_path, status: :see_other
  end

protected
  
def reject_end_user
  @end_user = EndUser.find_by(email: params[:end_user][:email])
  if @end_user
    if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
      redirect_to new_end_user_registration_path
    else
      flash[:notice] = t('item_blank')
    end
  else
    flash[:notice] = t('not_found')
  end
 end
end 