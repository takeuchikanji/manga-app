class AddColmunToComics < ActiveRecord::Migration[6.0]
  def change
    add_column :comics, :booknumber_id, :integer, null: false
  end
end
