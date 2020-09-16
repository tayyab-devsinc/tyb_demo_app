class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.float :unit_price, null: false, min: 0, default: 0
      t.integer :max_unit_price, null: false, min: 0, default: 0
      t.timestamps
    end
    add_index :features, :code
  end
end
