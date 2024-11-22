class AddCodeToAssistant < ActiveRecord::Migration[7.0]
  def change
    add_column :assistants, :code, :string
  end
end
