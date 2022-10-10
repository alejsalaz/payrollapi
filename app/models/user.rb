class User < ApplicationRecord
  require 'securerandom'

  belongs_to :company
  has_secure_password

  scope :filter_by_company, ->(company_id) { where company_id: company_id }

  validates :full_name,
            presence: {
              code: '001'
            },
            length: {
              minimum: 5,
              code: '003'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              on: :create,
              code: '004'
            }

  validates :email,
            presence: {
              code: '005'
            },
            uniqueness: {
              code: '006'
            },
            format: {
              with: /\A(\S+)@(.+)\.(\S+)\z/,
              on: :create,
              code: '007'
            }

  validates :password,
            presence: {
              code: '008'
            },
            length: {
              minimum: 6,
              code: '009'
            }
end
