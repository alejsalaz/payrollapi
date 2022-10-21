class Company < ApplicationRecord
  has_many :users
  has_many :employees
  has_many :periods
  has_many :payrolls, through: :employees

  validates :nit,
            presence: {
              code: '011'
            },
            uniqueness: {
              case_sensitive: false,
              code: '012',
              on: :create
            },
            length: {
              minimum: 8,
              code: '013'
            },
            format: {
              with: /\A\d+\z/,
              code: '014'
            }

  validates :legal_name,
            presence: {
              code: '015'
            },
            uniqueness: {
              case_sensitive: false,
              code: '016'
            },
            length: {
              minimum: 3,
              code: '017'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              code: '018'
            }

  validates :display_name,
            allow_blank: true,
            length: {
              minimum: 3,
              code: '019'
            },
            uniqueness: {
              case_sensitive: false,
              code: '020'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              code: '021'
            }
end
