require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Relations
  should belong_to(:company)
  should have_many(:payrolls)
  # Validations
  should validate_presence_of(:card_id)
  should validate_uniqueness_of(:card_id)
    .case_insensitive
  should validate_length_of(:card_id)
    .is_at_least(8)
  should allow_values('1000000000', '40000000')
    .for(:card_id)
  should_not allow_values('J4ir0 Normand|a', 'Ñañ° Fern4ndez', '')
    .for(:card_id)

  should validate_presence_of(:full_name)
  should validate_length_of(:full_name)
    .is_at_least(5)
  should allow_values('Jairo Orjuela', 'Alexis Franco')
    .for(:full_name)
  should_not allow_values('breann@gleichner', '@schinner.net', '')
    .for(:full_name)

  should validate_presence_of(:risk_class)
  should allow_values('i', 'ii', 'ii', 'iv', 'v')
    .for(:risk_class)
  should_not allow_values('1', 'iiii', 'a', '')
    .for(:risk_class)
  should validate_inclusion_of(:risk_class)
    .in_array(%w[i ii ii iv v])

  should validate_presence_of(:job_title)
  should validate_length_of(:job_title)
    .is_at_least(3)
  should allow_values('Desarrollador backend', 'Desarrollador frontend')
    .for(:job_title)
  should_not allow_values('.@-16', '@schinner.net', '')
    .for(:job_title)

  should validate_presence_of(:base_salary)
  should allow_values(1_000_000, 750_000, 2_500_000)
    .for(:base_salary)
  should_not allow_values('superadmin', '1ooooooo', '1+1', '')
    .for(:base_salary)
  should validate_numericality_of(:base_salary)

  should validate_presence_of(:start_date)
  should allow_values(
    Date.new(Date.today.year, Date.today.month),
    Date.new(Date.today.year, Date.today.month - 1),
    Date.new(Date.today.year, Date.today.month - 2)
  ).for(:start_date)
  should_not allow_values(
    Date.new(Date.today.year, Date.today.month, Date.today.day + 2),
    Date.new(Date.today.year, Date.today.month + 1),
    Date.new(Date.today.year, Date.today.month + 2),
    ''
  ).for(:start_date)

  should allow_values(
    Date.new(Date.today.year, Date.today.month, Date.today.day + 2),
    Date.new(Date.today.year, Date.today.month + 1),
    Date.new(Date.today.year, Date.today.month + 2)
  ).for(:termination_date)
  should_not allow_values(
    Date.new(Date.today.year, Date.today.month, Date.today.day + 1),
    Date.new(Date.today.year, Date.today.month - 1),
    Date.new(Date.today.year, Date.today.month - 2),
    ''
  ).for(:termination_date)

  should validate_presence_of(:contract_type)
  should allow_values('work or labor', 'fixed-term', 'indefinite', 'apprenticeship', 'temporary')
    .for(:contract_type)
  should_not allow_values('1', 1, 'fixedterm', '')
    .for(:contract_type)
  should validate_inclusion_of(:contract_type)
    .in_array(['work or labor', 'fixed-term', 'indefinite', 'apprenticeship', 'temporary'])
  # Columns
  should have_db_column(:id)
    .of_type(:uuid)
  should have_db_column(:card_id)
    .of_type(:string)
  should have_db_column(:company_id)
    .of_type(:uuid)
  should have_db_column(:full_name)
    .of_type(:string)
  should have_db_column(:risk_class)
    .of_type(:enum)
  should have_db_column(:job_title)
    .of_type(:string)
  should have_db_column(:base_salary)
    .of_type(:decimal)
  should have_db_column(:start_date)
    .of_type(:date)
  should have_db_column(:termination_date)
    .of_type(:date)
  should have_db_column(:contract_type)
    .of_type(:enum)
end
