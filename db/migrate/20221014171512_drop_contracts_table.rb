class DropContractsTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :employees, :contracts
    drop_table :contracts
    add_column :employees, :job_title, :string, null: false
    add_column :employees, :base_salary, :decimal, null: false
    add_column :employees, :start_date, :date, null: false
    add_column :employees, :termination_date, :date, null: false
    add_column :employees, :type, :contract_type, null: false
  end
end
