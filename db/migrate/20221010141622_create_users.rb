class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name, null: false
      t.citext :email, null: false
      t.string :password_digest, null: false
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end

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
