class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :description
      t.integer :year
      t.string :director

      t.timestamps
    end
  end
end
