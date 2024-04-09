class CreateWeightLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :weight_logs do |t|
      t.integer :user_id
      t.float :weight
      t.date :measured_on

      t.timestamps
    end
  end
end
