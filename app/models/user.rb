# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  belongs_to :company
  has_secure_password

  ROLES = %w[admin accountant user].freeze

  scope :filter_by_company, ->(company_id) { where company_id: company_id }

  validates :full_name,
            presence: {
              code: '001'
            },
            length: {
              minimum: 5,
              code: '002'
            },
            format: {
              with: /\A[\w áéíúóúÁÉÍÓÚñÑ]+\z/,
              code: '003'
            }

  validates :email,
            presence: {
              code: '004'
            },
            uniqueness: {
              code: '005'
            },
            format: {
              with: /\A(\S+)@(.+)\.(\S+)\z/,
              code: '006'
            }

  validates :password,
            presence: {
              code: '007'
            },
            length: {
              minimum: 6,
              code: '008'
            }

  validates :role,
            presence: {
              code: '009'
            },
            inclusion: {
              in: ROLES,
              code: '010'
            }
end
