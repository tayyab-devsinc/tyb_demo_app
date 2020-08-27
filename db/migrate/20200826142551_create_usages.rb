class CreateUsages < ActiveRecord::Migration[5.1]
  def change
    create_table :usages do |t|
      t.belongs_to :subscription, null: false
      t.belongs_to :feature, null: false
      t.integer :feature_count, null: false, min: 0

      t.timestamps
    end
  end
end
