# frozen_string_literal: true

class Payroll < ApplicationRecord
  belongs_to :employee
  belongs_to :period

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
end
