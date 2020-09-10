class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :genre, null: false
      t.index :genre, unique: true
      t.timestamps
    end
  end
end
