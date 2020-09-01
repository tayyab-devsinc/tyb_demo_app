class RenameTypeToAdmin < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :type, :admin
  end
end
