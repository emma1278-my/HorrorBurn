class MovieWeightLossGoalsController < ApplicationController
  
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      # ここでBMIの計算を行う
      bmi = calculate_bmi(@profile)
      
      # 計算結果をWeightLossGoalsテーブルに保存
      @weight_loss_goal = WeightLossGoals.new(bmi: bmi, profile_id: @profile.id)
      if @weight_loss_goal.save
        redirect_to @profile, notice: '目標が保存されました'
      else
        # WeightLossGoalsの保存に失敗した場合の処理
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:weight)
  end
  
end
