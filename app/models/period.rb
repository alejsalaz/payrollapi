# frozen_string_literal: true

class Period < ApplicationRecord
  include DateHelper

  belongs_to :company
  has_many :payrolls

  STATES = %w[paid draft failed].freeze

  validate :dates_format
  validate :dates_coherence

  validates :start_date,
            presence: {
              code: '025'
            },
            uniqueness: {
              case_sensitive: false,
              code: '026'
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
            uniqueness: {
              case_sensitive: false,
              code: '029'
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
