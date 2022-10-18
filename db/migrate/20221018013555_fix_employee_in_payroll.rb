class FixEmployeeInPayroll < ActiveRecord::Migration[7.0]
  def change
    change_column :payrolls, :employee_healthcare, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :employee_pension, :decimal, null: false, precision: 17, scale: 2, default: 0
  end
end
