class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.string :name
      t.string :code
      t.float :unit_price
      t.integer :max_unit_price

      t.timestamps
    end
    add_index :features, :name
    add_index :features, :code
  end
end
