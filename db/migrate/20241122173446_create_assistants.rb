class CreateAssistants < ActiveRecord::Migration[7.0]
  def change
    create_table :assistants do |t|
      t.string :name, null: false
      t.references :enterprise, null: false, foreign_key: true
      t.string :description
      t.text :prompt, null: false
      t.string :model

      t.timestamps
    end
  end
end
