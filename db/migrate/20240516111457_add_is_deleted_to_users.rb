class AddIsDeletedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_deleted, :boolean unless column_exists?(:users, :is_deleted)
  end
end
