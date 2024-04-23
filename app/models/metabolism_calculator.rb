class MetabolismCalculator < ApplicationRecord
  include ActiveModel::Model

  attr_accessor :weight

  def calculate_runtime(target_calories)
    calories_per_movie = 113 # 90分のホラー映画で消費されるカロリー
    movie_runtime = 90 # ホラー映画の時間（分）
    
    necessary_runtime = (target_calories.to_f / calories_per_movie) * movie_duration
    
    necessary_viewing_time # 必要な視聴時間を返す
  end
  
  # 使用例
  target_calories = 770 # 目標消費カロリー
  viewing_time = calculate_runtime(target_calories)
  puts "必要な視聴時間: #{runtime}分"
end
