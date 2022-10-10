class Company < ApplicationRecord
  has_many :users

  validates :nit,
            presence: {
              code: '010'
            },
            length: {
              minimum: 8,
              code: '011'
            },
            format: {
              with: /\A\d+\z/,
              on: :create,
              code: '012'
            }

  validates :legal_name,
            presence: {
              code: '013'
            },
            length: {
              minimum: 8,
              code: '014'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ',.-]+\z/,
              on: :create,
              code: '015'
            }

  validates :display_name,
            allow_blank: true,
            length: {
              minimum: 4,
              code: '014'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              on: :create,
              code: '016'
            }
end
