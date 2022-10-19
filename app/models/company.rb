class Company < ApplicationRecord
  has_many :users
  has_many :employees
  has_many :periods
  has_many :payrolls, through: :employees

  validates :nit,
            presence: {
              code: '012'
            },
            uniqueness: {
              case_sensitive: false,
              code: '013'
            },
            length: {
              minimum: 8,
              code: '014'
            },
            format: {
              with: /\A\d+\z/,
              code: '015'
            }

  validates :legal_name,
            presence: {
              code: '016'
            },
            uniqueness: {
              case_sensitive: false,
              code: '017'
            },
            length: {
              minimum: 3,
              code: '018'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              code: '019'
            }

  validates :display_name,
            allow_blank: true,
            length: {
              minimum: 3,
              code: '020'
            },
            uniqueness: {
              case_sensitive: false,
              code: '021'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              code: '022'
            }
end
