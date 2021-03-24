class CreateCollectionsItemsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :collections, :items do |t|
      t.index :item_id
      t.index :collection_id
    end
  end
end
