class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      # ログインに成功した場合、root_pathにリダイレクト
      redirect_to root_path
    else
      # ログインに失敗した場合、ログインページにリダイレクト
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
  