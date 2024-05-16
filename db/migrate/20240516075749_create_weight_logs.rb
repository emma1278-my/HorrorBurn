class CreateWeightLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :weight_logs do |t|
      t.float :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
