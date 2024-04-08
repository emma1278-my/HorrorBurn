class MetabolismCalculatorsController < ApplicationController
  skip_before_action :require_login, only: [:new, :show]

  def new
    # ここでは特に初期化処理は必要ないが、フォームオブジェクトなどを使う場合はここで初期化する
  end

  def create
    # ここでフォームからの入力値を基に計算を行い、結果をセッションなどに保存
    # 計算結果をshowアクションで表示するためには、その結果をどこかに一時的に保存する必要がある
    # ここでは例としてセッションを使用
    session[:calculation_result] = 計算結果
    redirect_to metabolism_calculator_path(id: 何かしらの識別子)
  end

  def show
    # createアクションで計算し保存した結果を取り出す
    @result = session[:calculation_result]
  end
end