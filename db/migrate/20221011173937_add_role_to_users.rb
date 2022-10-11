class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('admin', 'accountant', 'user');
    SQL
    add_column :users, :role, :user_role, null: false, default: 'user'
  end

  def down
    remove_column :users, :role
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
