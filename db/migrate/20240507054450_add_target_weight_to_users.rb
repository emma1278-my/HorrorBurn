class AddTargetWeightToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :target_weight, :float
  end
end
