class AddUniqueIndexToPayroll < ActiveRecord::Migration[7.0]
  def change
    add_index :payrolls, %i[employee_id period_id], unique: true
  end
end
