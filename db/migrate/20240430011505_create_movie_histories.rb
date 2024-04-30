class CreateMovieHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :movie_id

      t.timestamps
    end
  end
end
