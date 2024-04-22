class ProfilesController < ApplicationController
  before_action :set_user,only: %i[edit update]

    def show
     # @profile = Profile.find(params[:id])
     # @bmr = @profile.calculate_bmr
    end
        
    def edit; end

    def update
      if @user.update(user_params)
        redirect_to profile_path, success: t('defaults.flash_message.updated', item: User.model_name.human)
      else
        flash.now['danger'] = t('defaults.flash_message.not_updated', item: User.model_name.human)
        render :edit, status: :unprocessable_entity
      end
    end
  
    def create
      # フォームからの入力値をもとにMetabolismCalculatorインスタンスを作成
      calculator = MetabolismCalculator.new(calculator_params)
      bmr = calculator.calculate_bmr.round(2)
  
      # ここでProfileを新規作成し、計算結果を保存
      #profile = Profile.new(user_id: current_user.id, bmr: bmr, ...)
      #if profile.save
       # redirect_to profile_path(profile), notice: 'プロフィールを作成しました。'
    #  else
       # render :new
     # end
    end
  
    private
  
    def set_user
      @user = User.find(current_user.id)
    end
  
    def user_params
      params.require(:user).permit(:email, :name, :avatar, :avatar_cash, :height, :weight, :gender)
    end

    def calculator_params
      params.require(:metabolism_calculator).permit(:weight, :height, :age, :gender)
    end
  end

  

  