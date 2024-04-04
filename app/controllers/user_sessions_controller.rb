class UserSessionsController < ApplicationController
  skip_before_action :require_login
 
  def new; end

  def create
     @user = login(params[:email], params[:password])
    if @user
      flash[:success] = t(".success")
      redirect_back_or_to root_path
    else
      flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, danger: t('user_sessions.destroy.success')
  end
  
protected
  
def reject_end_user
  @end_user = EndUser.find_by(email: params[:end_user][:email])
  if @end_user
    if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_end_user_registration_path
    else
      flash[:notice] = "項目を入力してください"
    end
  else
    flash[:notice] = "該当するユーザーが見つかりません"
  end
end
end 