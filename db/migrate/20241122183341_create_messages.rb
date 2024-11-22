class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :assistant, null: false, foreign_key: true
      t.string :thread_id, null: false
      t.jsonb :messages

      t.timestamps
    end
  end
end
