json.extract! payroll, :id, :employee_id, :period_id, :salary_income, :non_salary_income, :deduction, :transportation, :healthcare, :pension, :solidarity_fund, :subsistence_account, :compensation_fund, :icbf, :sena, :severance, :interest, :premium, :vacation, :created_at, :updated_at
json.url payroll_url(payroll, format: :json)
