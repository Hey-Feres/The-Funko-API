class CreateDataFetches < ActiveRecord::Migration[6.0]
  def change
    create_table :data_fetches do |t|
      t.json :data
      t.datetime :fetched_at

      t.timestamps
    end
  end
end
