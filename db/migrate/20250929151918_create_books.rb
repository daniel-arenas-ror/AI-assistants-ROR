class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :qualification, default: 0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
