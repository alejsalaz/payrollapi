# frozen_string_literal: true

class Employee < ApplicationRecord
  include SalaryHelper

  belongs_to :company

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

  validates :card_id,
            presence: {
              code: '036'
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
              code: '042'
            }

  validates :risk_class,
            presence: {
              code: '043'
            },
            inclusion: {
              in: CLASSES,
              code: '044'
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
            },
            numericality: {
              greater_than_or_equal_to: MINIMUM_WAGE,
              code: '049'
            }

  validates :start_date,
            presence: {
              code: '050'
            },
            inclusion: {
              in: ((77.years.ago)..(1.days.from_now)),
              code: '051'
            }

  validates :termination_date,
            inclusion: {
              in: ((1.days.from_now)..(77.years.from_now)),
              code: '053'
            }

  validates :type,
            presence: {
              code: '054'
            },
            inclusion: {
              in: TYPES,
              code: '055'
            }
end
