class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :runtime
      t.string :release_date
    
      t.timestamps
    end
  end
end
