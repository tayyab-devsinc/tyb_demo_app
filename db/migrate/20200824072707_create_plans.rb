class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :plans, :name
  end
end
