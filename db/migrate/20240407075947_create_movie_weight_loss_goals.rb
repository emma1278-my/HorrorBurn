class CreateMovieWeightLossGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_weight_loss_goals do |t|
      t.integer :user_id
      t.float :weight
      t.integer :calorie_burned
      t.integer :runtime
      t.date :weight_achieved_date

      t.timestamps
    end
    add_index :movie_weight_loss_goals, :user_id
  end
end
