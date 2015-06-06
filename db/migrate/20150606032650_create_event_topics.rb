class CreateEventTopics < ActiveRecord::Migration
  def change
    create_table :event_topics do |t|
      t.integer :event_id, null: false
      t.integer :topic_id, null: false
      t.timestamps null: false
    end

    add_index :event_topics, :event_id
    add_index :event_topics, :topic_id

  end
end
