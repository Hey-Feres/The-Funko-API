class AddSlugToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :brands,     :slug, :string
    add_column :categories, :slug, :string
    add_column :events,     :slug, :string
    add_column :features,   :slug, :string
    add_column :items,      :slug, :string
    add_column :licenses,   :slug, :string
  end
end
