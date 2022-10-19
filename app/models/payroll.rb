# frozen_string_literal: true

class Payroll < ApplicationRecord
  include PayrollHelper

  belongs_to :employee
  belongs_to :period

  validate :valid_attributes?

  validates :salary_income,
            numericality: {
              code: '033'
            }

  validates :non_salary_income,
            numericality: {
              code: '034'
            }

  validates :deduction,
            numericality: {
              code: '035'
            }

  validates :period_id,
            uniqueness: {
              case_sensitive: false,
              code: '013',
              on: :create
            }

  after_validation :set_variables
  after_validation :set_transportation
  after_validation :set_employee_healthcare
  after_validation :set_employee_pension
  after_validation :set_solidarity_fund
  after_validation :set_subsistence_account
  after_validation :set_compensation_fund
  after_validation :set_icbf
  after_validation :set_sena
  after_validation :set_severance
  after_validation :set_interest
  after_validation :set_premium
  after_validation :set_vacation
  after_validation :set_employer_healthcare
  after_validation :set_employer_pension
  after_validation :set_arl
end
