class DropContractsColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :contract_id
  end
end
