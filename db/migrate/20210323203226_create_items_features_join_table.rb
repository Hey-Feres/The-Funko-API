class CreateItemsFeaturesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :items, :features do |t|
      t.index :item_id
      t.index :feature_id
    end
  end
end
