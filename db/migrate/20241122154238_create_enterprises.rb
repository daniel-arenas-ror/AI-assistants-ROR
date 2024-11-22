class CreateEnterprises < ActiveRecord::Migration[7.0]
  def change
    create_table :enterprises do |t|
      t.string :name
      t.string :ai_api_key
      t.string :ai_source

      t.timestamps
    end
  end
end
