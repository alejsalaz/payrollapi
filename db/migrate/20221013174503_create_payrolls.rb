class CreatePayrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :payrolls, id: :uuid do |t|
      t.references :employee, null: false, foreign_key: true, type: :uuid
      t.references :period, null: false, foreign_key: true, type: :uuid
      t.decimal :salary_income, null: false
      t.decimal :non_salary_income, null: false
      t.decimal :deduction, null: false
      t.decimal :transportation, null: false
      t.decimal :healthcare, null: false
      t.decimal :pension, null: false
      t.decimal :solidarity_fund, null: false
      t.decimal :subsistence_account, null: false
      t.decimal :compensation_fund, null: false
      t.decimal :icbf, null: false
      t.decimal :sena, null: false
      t.decimal :severance, null: false
      t.decimal :interest, null: false
      t.decimal :premium, null: false
      t.decimal :vacation, null: false

      t.timestamps
    end
  end
end
