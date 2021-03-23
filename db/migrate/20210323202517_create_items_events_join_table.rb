class CreateItemsEventsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :items, :events do |t|
      t.index :item_id
      t.index :event_id
    end
  end
end
