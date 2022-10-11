class Company < ApplicationRecord
  has_many :users

  validates :nit,
            presence: {
              code: '012'
            },
            length: {
              minimum: 8,
              code: '013'
            },
            format: {
              with: /\A\d+\z/,
              on: :create,
              code: '014'
            }

  validates :legal_name,
            presence: {
              code: '015'
            },
            length: {
              minimum: 3,
              code: '016'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              on: :create,
              code: '017'
            }

  validates :display_name,
            allow_blank: true,
            length: {
              minimum: 4,
              code: '018'
            },
            format: {
              with: /\A[a-zA-Z áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              on: :create,
              code: '019'
            }
end
