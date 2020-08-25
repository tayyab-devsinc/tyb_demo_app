class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user
      t.belongs_to :plan
      t.datetime :subscription_date, null: false
      t.integer :billing_day, null: false
      t.boolean :active, default: true, null: false
      t.timestamps
    end
    add_index :subscriptions, [:user_id, :plan_id], unique: true
  end
end
