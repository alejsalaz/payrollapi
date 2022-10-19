# frozen_string_literal: true

class Period < ApplicationRecord
  include DateHelper

  belongs_to :company
  has_many :payrolls

  STATES = %w[paid draft failed].freeze

  scope :filter_by_company, ->(company_id) { where company_id: company_id }

  validate :dates_format
  validate :dates_coherence
  validate :dates_uniqueness, on: :create

  validates :start_date,
            presence: {
              code: '025'
            },
            inclusion: {
              in: (
                (Date.new(Date.today.year, Date.today.month) - 2.years)..
                (Date.new(Date.today.year, Date.today.month))
              ),
              code: '027'
            }
  validates :end_date,
            presence: {
              code: '028'
            },
            inclusion: {
              in: (
                (Date.new(Date.today.year, Date.today.month) - 2.years).end_of_month..
                (Date.new(Date.today.year, Date.today.month).end_of_month)
              ),
              code: '030'
            }

  validates :state,
            presence: {
              code: '031'
            },
            inclusion: {
              in: STATES,
              code: '032'
            }
end
