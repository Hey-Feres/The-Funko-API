class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :number
      t.string :title
      t.string :form_factor
      t.string :features
      t.string :inner_case_count
      t.string :master_case_quantity
      t.string :status
      t.string :image_url
      t.references :category
      t.references :license
      t.references :brand

      t.timestamps
    end
  end
end
