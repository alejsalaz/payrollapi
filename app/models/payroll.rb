# frozen_string_literal: true

class Payroll < ApplicationRecord
  include PayrollHelper

  belongs_to :employee
  belongs_to :period
  has_one :company, through: :employee

  validate :valid_attributes?, on: :create unless Rails.env.test?

  validates :salary_income,
            numericality: {
              code: '051'
            }

  validates :non_salary_income,
            numericality: {
              code: '052'
            }

  validates :deduction,
            numericality: {
              code: '053'
            }

  validates :employee,
            uniqueness: {
              scope: :period,
              code: '054',
              on: :create
            }

  unless Rails.env.test?
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
end
