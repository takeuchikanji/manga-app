class CreateComicGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :comic_genres do |t|
      t.references :comic, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
