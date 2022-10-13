# frozen_string_literal: true

class Payroll < ApplicationRecord
  belongs_to :employee
  belongs_to :period
  belongs_to :user

  validates :salary_income,
            numericality: {
              code: '032'
            }

  validates :non_salary_income,
            numericality: {
              code: '033'
            }

  validates :deduction,
            numericality: {
              code: '034'
            }
end
