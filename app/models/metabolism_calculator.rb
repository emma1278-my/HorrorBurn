class MetabolismCalculator < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :weight, :height, :age, :gender
  
  def calculate_bmr(weight, height, age, gender)
    gender_index = gender == "male" ? 0.5473 : 0.5473 * 2
    bmr = (0.1238 + (0.0481 * weight) + (0.0234 * height) - (0.0138 * age) - gender_index) * 1000 / 4.186
    bmr.round(2) # 小数点以下2桁で丸める
  end

  def total_calories_consumpted(bmr)
    bmr * 1.2
  end

  def total_hours_needed_for_movies(total_calories)
  # ホラー映画を観て消費されるカロリーで割る
  movie_sessions_needed = total_calories / 113.0 
  # 必要なホラー映画視聴回数に90分を乗じて総視聴時間を求める
  movie_sessions_needed * 90 
  end
end
