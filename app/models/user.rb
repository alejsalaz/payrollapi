class User < ApplicationRecord
  require 'securerandom'

  belongs_to :company
  has_secure_password

  validates :full_name,
            presence: {
              message: 'must be present',
              code: '001'
            },
            length: {
              minimum: 5,
              too_short: 'is too short, it should be at least 5 characters long',
              code: '003'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚ]+\z/,
              on: :create,
              message: 'cannot contain special characters',
              code: '004'
            }

  validates :email,
            presence: {
              message: 'must be present',
              code: '005'
            },
            uniqueness: {
              message: 'already exists',
              code: '006'
            },
            format: {
              with: /\A(\S+)@(.+)\.(\S+)\z/,
              on: :create,
              message: 'cannot contain special characters',
              code: '007'
            }

  validates :password,
            presence: {
              message: 'must be present',
              code: '008'
            },
            length: {
              minimum: 6,
              too_short: 'is too short, it should be at least 6 characters long',
              code: '009'
            }
end
