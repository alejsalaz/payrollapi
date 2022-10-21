# frozen_string_literal: true

class Employee < ApplicationRecord
  include SalaryHelper

  belongs_to :company
  has_many :payrolls

  CLASSES = %w[
    i
    ii
    iii
    iv
    v
  ].freeze

  TYPES = [
    'work or labor',
    'fixed-term',
    'indefinite',
    'apprenticeship',
    'temporary'
  ].freeze

  scope :filter_by_company, ->(company_id) { where company_id: company_id }

  validate :valid_minimum_wage? unless Rails.env.test?

  validates :card_id,
            presence: {
              # TODO: Codes are pending
              code: '022'
            },
            uniqueness: {
              case_sensitive: false,
              code: '023'
            },
            length: {
              minimum: 8,
              code: '024'
            },
            format: {
              with: /\A\d+\z/,
              code: '025'
            }

  validates :full_name,
            presence: {
              code: '026'
            },
            length: {
              minimum: 5,
              code: '027'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: '028'
            }

  validates :risk_class,
            presence: {
              code: '029'
            },
            inclusion: {
              in: CLASSES,
              code: '030'
            }

  validates :job_title,
            presence: {
              code: '031'
            },
            length: {
              minimum: 3,
              code: '032'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: '033'
            }

  validates :base_salary,
            presence: {
              code: '034'
            },
            numericality: {
              code: '035'
            }

  validates :start_date,
            presence: {
              code: '036'
            },
            inclusion: {
              in: ((77.years.ago)..(1.days.from_now)),
              code: '037'
            }

  validates :termination_date,
            inclusion: {
              in: ((1.days.from_now)..(77.years.from_now)),
              code: '038'
            }

  validates :contract_type,
            presence: {
              code: '039'
            },
            inclusion: {
              in: TYPES,
              code: '040'
            }

  private

  def valid_minimum_wage?
    return false unless contract_type.present? && base_salary.present?

    return true if contract_type != 'apprenticeship' && base_salary > MINIMUM_WAGE
    return true if contract_type.eql?('apprenticeship') && base_salary > MINIMUM_WAGE * SENA_APPRENTICESHIP

    errors.add(
      :base,
      'la cantidad ingresada es incorrecta',
      code: '041'
    )
  end
end
