class CreateUsages < ActiveRecord::Migration[5.1]
  def change
    create_table :usages do |t|
      t.belongs_to :subscription
      t.integer :feature_count

      t.timestamps
    end
  end
end
