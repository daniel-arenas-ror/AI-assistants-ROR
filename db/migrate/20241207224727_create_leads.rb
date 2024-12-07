class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.references :enterprise, null: false, foreign_key: true
      t.jsonb :extra_data

      t.timestamps
    end
  end
end
