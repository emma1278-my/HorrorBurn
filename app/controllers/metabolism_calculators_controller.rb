class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show]

  def new
    # 新規作成ページ
  end

  def show;end

  
end