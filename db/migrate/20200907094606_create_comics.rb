class CreateComics < ActiveRecord::Migration[6.0]
  def change
    create_table :comics do |t|
      t.string :name, null: false
      t.string :image
      t.integer :number_of_books, null: false
      t.text :summary, null: false
      t.text :review, null: false
      t.timestamps
    end
  end
end
