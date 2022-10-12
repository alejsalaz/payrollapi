# frozen_string_literal: true

require 'test_helper'

module V1
  class AuthenticationControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @user = users(:valid_user)
    end

    test 'should login with valid user' do
      login(@user)
      assert_response :success
    end
  end
end
