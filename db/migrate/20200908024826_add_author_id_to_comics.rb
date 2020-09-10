class AddAuthorIdToComics < ActiveRecord::Migration[6.0]
  def change
    add_reference :comics, :author, foreign_key: true
  end
end
