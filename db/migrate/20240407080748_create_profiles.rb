class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :gender
      t.integer :age
      t.float :height

      t.timestamps
    end
  end
end
