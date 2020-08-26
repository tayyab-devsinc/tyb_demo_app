class RemovePlanMonthlyFeeColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :plans, :monthly_fee
  end
end
