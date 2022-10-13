class Contract < ApplicationRecord
  include SalaryHelper

  belongs_to :employee

  validates :job_title,
            presence: {
              code: '035'
            },
            length: {
              minimum: 3,
              code: '036'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: '037'
            }

  validates :base_salary,
            presence: {
              code: '038'
            },
            numericality: {
              greater_than_or_equal_to: MINIMUM_WAGE,
              code: '039'
            }

  validates :start_date,
            presence: {
              code: '040'
            },
            inclusion: {
              in: ((77.years.ago)..(1.days.from_now)),
              code: '041'
            }

  # TODO: Aquí voy
  validates :end_date,
            presence: {
              code: '040'
            },
            inclusion: {
              in: ((1.days.from_now)..(1.days.from_now)),
              code: '041'
            }
end
