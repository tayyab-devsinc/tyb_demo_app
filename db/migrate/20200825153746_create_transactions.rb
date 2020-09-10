class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user
      t.belongs_to :subscription
      t.float :amount

      t.timestamps
    end
    add_index :transactions, [:user_id, :subscription_id]
  end
end
