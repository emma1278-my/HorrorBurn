class CreateMoviesHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :movies_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      
      t.date :added_at

      t.timestamps
    end
  end
end
