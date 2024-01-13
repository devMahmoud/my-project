class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :user_name
      t.integer :stars, null: false
      t.text :text
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
