# frozen_string_literal: true

module SalaryHelper
  MINIMUM_WAGE = 1_000_000
  SENA_APPRENTICESHIP = 0.50
  TRANSPORTATION_SUBSIDY = 117_172
  EMPLOYEE_HEALTHCARE = 0.04
  EMPLOYER_HEALTHCARE = 0.85
  EMPLOYEE_PENSION = 0.04
  EMPLOYER_PENSION = 0.12
  ARL_PERCENTAGES = {
    i: 0.522,
    ii: 1.044,
    iii: 2.436,
    iv: 4.350,
    v: 6.960
  }.freeze
  COMPENSATION_FUND = 0.4
  ICBF = 0.3
  SENA = 0.2
  BONUS = 1.0 / 12.0
  SEVERANCE = 1.0 / 12.0
  INTEREST = 0.12
  VACATION = 1.0 / 24.0

  private

  def valid_minimum_wage?
    return true if contract_type != 'apprenticeship' && base_salary > MINIMUM_WAGE
    return true if contract_type.eql?('apprenticeship') && base_salary > MINIMUM_WAGE * SENA_APPRENTICESHIP

    errors.add(
      :base,
      'la cantidad ingresada es incorrecta',
      code: '049'
    )
  end
end
