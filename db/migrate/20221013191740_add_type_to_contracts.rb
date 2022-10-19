class AddTypeToContracts < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE contract_type AS ENUM ('work or labor', 'fixed-term', 'indefinite', 'apprenticeship', 'temporary');
    SQL
    add_column :contracts, :type, :contract_type, null: false
  end

  def down
    remove_column :contracts, :type
    execute <<-SQL
      DROP TYPE contract_type;
    SQL
  end
end
