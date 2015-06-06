class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id, null: false
      t.integer :topic_id, null: false
      t.timestamps null: false
    end
    add_index :interests, :user_id
    add_index :interests, :topic_id
  end
end
