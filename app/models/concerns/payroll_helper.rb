# frozen_string_literal: true

module PayrollHelper
  include SalaryHelper

  INVALID_PARAMS = %w[
    transportation
    employee_healthcare
    employee_pension
    solidarity_fund
    subsistence_account
    compensation_fund
    icbf
    sena
    severance
    interest
    premium
    vacation
    employer_healthcare
    employer_pension
  ].freeze

  private

  def valid_attributes?
    return true if INVALID_PARAMS.all? { |param| send(param).zero? }

    errors.add(
      :base,
      'Ha ingresado parámetros no autorizados',
      code: '055'
    )
  end

  def set_variables
    @period_days = (Period.find_by(id: period_id).end_date - Period.find_by(id: period_id).start_date).to_i
    @salary = Employee.find_by(id: employee_id).base_salary * @period_days.to_i / 30
    @total_salary = @salary + non_salary_income
    @minimum_wages = @total_salary / MINIMUM_WAGE
  end

  def set_transportation
    self.transportation = @transportation = TRANSPORTATION_SUBSIDY * @period_days / 30 if @minimum_wages < 3
  end

  def set_employee_healthcare
    self.employee_healthcare = EMPLOYEE_HEALTHCARE * @total_salary
  end

  def set_employee_pension
    self.employee_pension = EMPLOYEE_PENSION * @total_salary
  end

  def set_solidarity_fund
    self.solidarity_fund = SOLIDARITY_FUND * @total_salary if @minimum_wages > 3
  end

  def set_subsistence_account
    return if @minimum_wages < 16

    self.subsistence_account = PENSION_SOLIDARITY_FUND + subsistence_fund * @total_salary
  end

  def subsistence_fund
    case @total_salary
    when 16...17
      0.002
    when 17...18
      0.004
    when 18...19
      0.006
    when 19...20
      0.008
    else
      0.01
    end
  end

  def set_compensation_fund
    self.compensation_fund = COMPENSATION_FUND * @total_salary
  end

  def set_icbf
    self.icbf = ICBF * @total_salary if @minimum_wages >= 10
  end

  def set_sena
    self.sena = SENA * @total_salary if @minimum_wages >= 10
  end

  def set_severance
    self.severance = @severance = (@total_salary + (@transportation || 0)) * SEVERANCE
  end

  def set_interest
    self.interest = (INTEREST * @severance).round
  end

  def set_premium
    self.premium = PREMIUM * (@total_salary + (@transportation || 0))
  end

  def set_vacation
    self.vacation = VACATION * @total_salary
  end

  def set_employer_healthcare
    self.employer_healthcare = EMPLOYER_HEALTHCARE * @total_salary if @minimum_wages > 10
  end

  def set_employer_pension
    self.employer_pension = EMPLOYER_PENSION * @total_salary
  end

  def set_arl
    self.arl = ARL_PERCENTAGES[Employee.find_by(id: employee_id).risk_class.to_sym] * @total_salary
  end
end
