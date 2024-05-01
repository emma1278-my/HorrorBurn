class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.float :current_weight
      t.integer :target_calorie
      t.float :target_weight
      t.integer :remaining_runtime
      t.date :weight_achieved_date
      
      t.timestamps
    end
  end
end
