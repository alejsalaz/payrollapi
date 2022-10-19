# frozen_string_literal: true

require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  # Relations
  should belong_to(:company)
  should have_many(:payrolls)
  # Validations
  should validate_presence_of(:start_date)
  should allow_values(
    Date.new(Date.today.year, Date.today.month) - 2.years,
    Date.new(Date.today.year, Date.today.month),
    Date.new(Date.today.year, Date.today.month - 2)
  ).for(:start_date)
  should_not allow_values(
    Date.new(Date.today.year, Date.today.month, Date.today.day + 2),
    Date.new(Date.today.year, Date.today.month + 1),
    Date.new(Date.today.year, Date.today.month + 2),
    ''
  ).for(:start_date)

  should validate_presence_of(:end_date)
  should allow_values(
    Date.new(Date.today.year, Date.today.month) - 3.months,
    Date.new(Date.today.year, Date.today.month).end_of_month,
    Date.new(Date.today.year, Date.today.month).end_of_month - 1.years
  ).for(:end_date)
  should_not allow_values(
    Date.new(Date.today.year, Date.today.month) + 2.years,
    Date.new(Date.today.year, Date.today.month).end_of_month + 1.months,
    Date.new(Date.today.year, Date.today.month).end_of_month + 1.years,
    ''
  ).for(:end_date)

  should validate_presence_of(:state)
  should allow_values('paid', 'draft', 'failed')
    .for(:state)
  should_not allow_values('1', 'drraft', 'a', '')
    .for(:state)
  should validate_inclusion_of(:state)
    .in_array(%w[paid draft failed])

  # Columns
  should have_db_column(:id)
    .of_type(:uuid)
  should have_db_column(:start_date)
    .of_type(:date)
  should have_db_column(:end_date)
    .of_type(:date)
  should have_db_column(:state)
    .of_type(:enum)
  should have_db_column(:company_id)
    .of_type(:uuid)
end
