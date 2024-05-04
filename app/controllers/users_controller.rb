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
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end


  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = t(".notice")
    redirect_to root_path
  end

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.uuid + "@example.com",
    password: 'password',
    password_confirmation: 'password',
    guest: true
    )
    auto_login(@guest_user)
    flash[:success] = t('.success')
    redirect_to new_metabolism_calculators_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはプロフィールを編集できないよ。'
    end
  end
end
