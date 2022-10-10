class User < ApplicationRecord
  require 'securerandom'

  belongs_to :company
  has_secure_password

  validates :full_name,
            presence: {
              # message: 'debe estar presente',
              code: '001'
            },
            length: {
              minimum: 5,
              # too_short: 'es muy corto, debe contener al menos 5 caracteres',
              code: '003'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚ]+\z/,
              on: :create,
              # message: 'no puede contener caracteres especiales',
              code: '004'
            }

  validates :email,
            presence: {
              # message: 'debe estar presente',
              code: '005'
            },
            uniqueness: {
              # message: 'ya existe',
              code: '006'
            },
            format: {
              with: /\A(\S+)@(.+)\.(\S+)\z/,
              on: :create,
              # message: 'no puede contener caracteres especiales',
              code: '007'
            }

  validates :password,
            presence: {
              # message: 'debe estar presente',
              code: '008'
            },
            length: {
              minimum: 6,
              # too_short: 'es muy corto, debe contener al menos 6 caracteres',
              code: '009'
            }
end
