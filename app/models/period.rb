# frozen_string_literal: true

class Period < ApplicationRecord
  include DateHelper

  belongs_to :company

  STATES = %w[paid draft failed].freeze

  validate :valid_dates?

  validates :start_date,
            presence: {
              code: '024'
            },
            uniqueness: {
              case_sensitive: false,
              code: '025'
            },
            inclusion: {
              in: ((Date.new(Date.today.year, Date.today.month))..(2.years.ago)),
              code: '026'
            }
  validates :end_date,
            presence: {
              code: '027'
            },
            uniqueness: {
              case_sensitive: false,
              code: '028'
            },
            inclusion: {
              in: ((Date.new(Date.today.year, Date.today.month).end_of_month)..(2.years.ago)),
              code: '029'
            }

  validates :state,
            presence: {
              code: '030'
            },
            inclusion: {
              in: STATES,
              code: '031'
            }
end
