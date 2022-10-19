# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Relations
  should belong_to(:company)
  # Validations
  should have_secure_password

  should validate_presence_of(:full_name)
  should allow_values('Jairo Normandía', 'Ñaño Fernández')
    .for(:full_name)
  should_not allow_values('J4ir0 Normand|a', 'Ñañ° Fern4ndez', '')
    .for(:full_name)
  should validate_length_of(:full_name)
    .is_at_least(5)

  should validate_presence_of(:email)
  should allow_values('breann@gleichner.name', 'bradley.windler@schinner.net')
    .for(:email)
  should_not allow_values('breann@gleichner', '@schinner.net', '')
    .for(:email)
  should validate_uniqueness_of(:email)
    .case_insensitive

  should validate_presence_of(:password)
  should allow_values('C76cZr0Rh', 'C76cZr0Rh')
    .for(:password)
  should validate_length_of(:password)
    .is_at_least(6)

  should validate_presence_of(:role)
  should allow_values('admin', 'accountant', 'user')
    .for(:role)
  should_not allow_values('superadmin', 'outsorcer', 'normal_user', '')
    .for(:role)
  should validate_inclusion_of(:role)
    .in_array(%w[admin accountant user])
  # Columns
  should have_db_column(:id)
    .of_type(:uuid)
  should have_db_column(:full_name)
    .of_type(:string)
  should have_db_column(:email)
    .of_type(:citext)
  should have_db_column(:password_digest)
    .of_type(:string)
  should have_db_column(:company_id)
    .of_type(:uuid)
  should have_db_column(:role)
    .of_type(:enum)
end
