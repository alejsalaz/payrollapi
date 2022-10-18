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

  validate :valid_minimum_wage?

  validates :card_id,
            presence: {
              # TODO: Codes are pending
              code: 'pending'
            },
            uniqueness: {
              case_sensitive: false,
              code: '037'
            },
            length: {
              minimum: 8,
              code: '038'
            },
            format: {
              with: /\A\d+\z/,
              code: '039'
            }

  validates :full_name,
            presence: {
              code: '040'
            },
            length: {
              minimum: 5,
              code: '041'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: 'pending'
            }

  validates :risk_class,
            presence: {
              code: '043'
            },
            inclusion: {
              in: CLASSES,
              code: 'pending'
            }

  validates :job_title,
            presence: {
              code: '045'
            },
            length: {
              minimum: 3,
              code: '046'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: '047'
            }

  validates :base_salary,
            presence: {
              code: '048'
            }

  validates :start_date,
            presence: {
              code: 'pending'
            },
            inclusion: {
              in: ((77.years.ago)..(1.days.from_now)),
              code: 'pending'
            }

  validates :termination_date,
            inclusion: {
              in: ((1.days.from_now)..(77.years.from_now)),
              code: '053'
            }

  validates :contract_type,
            presence: {
              code: '054'
            },
            inclusion: {
              in: TYPES,
              code: '055'
            }

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
