class Company < ApplicationRecord
  has_many :users

  validates :nit,
            presence: {
              # message: 'debe estar presente',
              code: '010'
            },
            length: {
              minimum: 8,
              # too_short: 'es muy corto, debería contener al menos 8 caracteres',
              code: '011'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚ]+\z/,
              on: :create,
              # message: 'no puede contener caracteres especiales',
              code: '012'
            }
end
