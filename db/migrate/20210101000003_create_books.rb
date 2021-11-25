class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :shelf, null: false
      t.references :author, null: false, foreign_key: true
      t.timestamps
    end
  end
end
