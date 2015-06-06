class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, limit: 200, null: false
      t.datetime :starts_at, null: false
      t.string :address, limit: 2000
      t.text :description

      t.timestamps null: false
    end
  end
end
