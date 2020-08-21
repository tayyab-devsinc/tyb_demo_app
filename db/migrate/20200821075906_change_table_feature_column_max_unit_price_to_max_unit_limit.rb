class ChangeTableFeatureColumnMaxUnitPriceToMaxUnitLimit < ActiveRecord::Migration[5.1]
  def change
    rename_column :features, :max_unit_price, :max_unit_limit
  end
end
