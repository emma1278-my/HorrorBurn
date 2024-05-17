class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :current_weight, :float
    add_column :users, :target_weight, :float
    add_column :users, :remaining_weight, :float
    add_column :users, :target_calorie, :float
    add_column :users, :remaining_runtime, :float
  end
end
