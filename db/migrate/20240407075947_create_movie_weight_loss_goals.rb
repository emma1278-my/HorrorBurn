class CreateMovieWeightLossGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_weight_loss_goals do |t|
      t.integer :user_id
   

   
  
      t.timestamps
    end
  end    
end
