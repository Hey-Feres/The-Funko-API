class CreateWishListsItemsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :wish_lists, :items do |t|
      t.index :item_id
      t.index :wish_list_id
    end
  end
end
