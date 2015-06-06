class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, limit: 100

      t.timestamps null: false
    end
    add_index :topics, :name, unique: true
  end
end
