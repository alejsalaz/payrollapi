class AddPayrollDefaults < ActiveRecord::Migration[7.0]
  def change
    change_column :payrolls, :salary_income, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :non_salary_income, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :deduction, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :transportation, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :employer_healthcare, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :employer_pension, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :solidarity_fund, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :subsistence_account, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :compensation_fund, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :icbf, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :sena, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :severance, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :interest, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :premium, :decimal, null: false, precision: 17, scale: 2, default: 0
    change_column :payrolls, :vacation, :decimal, null: false, precision: 17, scale: 2, default: 0
  end
end
