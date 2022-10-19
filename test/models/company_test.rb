# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # Relations
  should have_many(:users)
  # Validations
  should validate_presence_of(:nit)
  should allow_values('973042215', 976_961_516)
    .for(:nit)
  should_not allow_values('97eoa22i5', '97@9@151@', '')
    .for(:nit)
  should validate_length_of(:nit)
    .is_at_least(8)

  should validate_presence_of(:legal_name)
  should allow_values('Torphy-Funk', 'Wolff, Larson and Lemke')
    .for(:legal_name)
  should_not allow_values('T0rphy-Funk', 'W°|ff, Larson and Lemke', '')
    .for(:legal_name)
  should validate_uniqueness_of(:legal_name)
    .case_insensitive
  should validate_length_of(:legal_name)
    .is_at_least(3)

  should validate_uniqueness_of(:display_name)
    .case_insensitive
  should allow_values('Torphyapp', 'Wolffapp', '')
    .for(:display_name)
  should_not allow_values('T0rphy4pp', 'W0lff4pp')
    .for(:display_name)
  should validate_length_of(:display_name)
    .is_at_least(3)
  # Columns
  should have_db_column(:id)
    .of_type(:uuid)
  should have_db_column(:nit)
    .of_type(:string)
  should have_db_column(:legal_name)
    .of_type(:string)
  should have_db_column(:display_name)
    .of_type(:string)
end
