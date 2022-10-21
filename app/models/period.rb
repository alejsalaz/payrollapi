# frozen_string_literal: true

class Period < ApplicationRecord
  include DateHelper

  belongs_to :company
  has_many :payrolls

  STATES = %w[paid draft failed].freeze

  scope :filter_by_company, ->(company_id) { where company_id: company_id }

  unless Rails.env.test?
    validate :dates_format
    validate :dates_coherence
    validate :dates_uniqueness, on: :create
  end

  validates :start_date,
            presence: {
              code: '042'
            },
            inclusion: {
              in: (
                (Date.new(Date.today.year, Date.today.month) - 2.years)..
                (Date.new(Date.today.year, Date.today.month))
              ),
              code: '043'
            }
  validates :end_date,
            presence: {
              code: '044'
            },
            inclusion: {
              in: (
                (Date.new(Date.today.year, Date.today.month) - 2.years).end_of_month..
                (Date.new(Date.today.year, Date.today.month).end_of_month)
              ),
              code: '045'
            }

  validates :state,
            presence: {
              code: '046'
            },
            inclusion: {
              in: STATES,
              code: '047'
            }
end
