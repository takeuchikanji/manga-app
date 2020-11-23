class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :comicname, null: false
      t.string :authorname, null: false
      t.text :comment, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
