class AddContractToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_reference :employees, :contract, null: false, foreign_key: true, type: :uuid
  end
end
