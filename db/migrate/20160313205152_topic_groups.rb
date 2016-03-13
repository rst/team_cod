class TopicGroups < ActiveRecord::Migration
  def change
    add_column :topics, :topic_group, :string, default: 'uncategorized', null: false
  end
end
