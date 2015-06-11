class StartsAtNull < ActiveRecord::Migration
  def change
    change_column_null :events, :starts_at, true
  end
end
