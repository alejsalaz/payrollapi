class Company < ApplicationRecord
  has_many :users

  validates :nit,
            presence: {
              message: 'must be present',
              code: '010'
            },
            length: {
              minimum: 8,
              too_short: 'is too short, it should be at least 8 characters long',
              code: '011'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚ]+\z/,
              on: :create,
              message: 'cannot contain special characters',
              code: '004'
            }
end
