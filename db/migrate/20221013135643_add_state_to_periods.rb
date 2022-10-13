class AddStateToPeriods < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE period_state AS ENUM ('paid', 'draft', 'failed');
    SQL
    add_column :periods, :state, :period_state, null: false, default: 'draft'
  end

  def down
    remove_column :periods, :state
    execute <<-SQL
      DROP TYPE period_state;
    SQL
  end
end
