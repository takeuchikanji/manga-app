class AddColumnKanaToComics < ActiveRecord::Migration[6.0]
  def change
    add_column :comics, :name_kana, :string, null: false
  end
end
