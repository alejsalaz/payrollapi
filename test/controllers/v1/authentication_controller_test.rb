# frozen_string_literal: true

require 'test_helper'

module V1
  class AuthenticationControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @valid_user = users(:valid_user)
      @invalid_user = users(:invalid_user)
    end

    test 'should login with valid user' do
      login(@valid_user)
      assert_response :success
    end

    test 'should not login with invalid user' do
      login(@invalid_user)
      assert_response :unauthorized
    end
  end
end
