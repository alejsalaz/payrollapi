class FixDefaultUserRole < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role, :user_role, null: false, default: 'user'
  end
end
