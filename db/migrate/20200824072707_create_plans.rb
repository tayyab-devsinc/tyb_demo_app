class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.float :monthly_fee, null: false, min: 0, default: 0
      t.timestamps
    end
    add_index :plans, :name
  end
end
