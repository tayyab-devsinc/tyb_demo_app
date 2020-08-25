class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :users, foreign_key: true, null: false
      t.references :plans, foreign_key: true, null: false
      t.boolean :active, default: true, null: false
      t.string :billing_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
    add_index :subscriptions, [:id,:users_id, :plans_id], unique: true
  end
end
