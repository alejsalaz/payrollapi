class Company < ApplicationRecord

  has_many :users

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
              on: :create,
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
              on: :create,
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
              on: :create,
              code: '022'
            }
end
