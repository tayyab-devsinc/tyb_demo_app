class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.float :monthly_fee

      t.timestamps
    end
    add_index :plans, :name
  end
end
