class RenameContractType < ActiveRecord::Migration[7.0]
  def change
    rename_column :employees, :type, :contract_type
  end
end
