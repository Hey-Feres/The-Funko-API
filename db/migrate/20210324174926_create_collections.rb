class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.integer :estimated_value_cents
      t.references :user, null: false

      t.timestamps
    end
  end
end
