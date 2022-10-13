# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  belongs_to :company
  has_many :payrolls
  has_secure_password

  ROLES = %w[admin accountant user].freeze

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

  validates :role,
            presence: {
              code: '010'
            },
            inclusion: {
              in: ROLES,
              code: '011'
            }
end
