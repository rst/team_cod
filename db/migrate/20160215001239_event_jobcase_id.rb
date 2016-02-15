class EventJobcaseId < ActiveRecord::Migration
  def change
    add_column :events, :jobcase_id, :string
    add_index :events, :jobcase_id, unique: true
  end
end
