class CreateJoinTablePlansFeatures < ActiveRecord::Migration[5.1]
  def change
    create_join_table :plans, :features do |t|
      t.index [:plan_id, :feature_id], unique: true
    end
  end
end
