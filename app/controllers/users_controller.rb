class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t(".success")
      auto_login(@user)
      redirect_to root_path
    else
      flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end
  end


  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.uuid + "@email.com",
    password: 'password',
    password_confirmation: 'password',)
    auto_login(@guest_user)
    flash[:success] = t('.success')
    redirect_to new_metabolism_calculators_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
