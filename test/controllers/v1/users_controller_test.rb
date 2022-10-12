# frozen_string_literal: true

require 'test_helper'

module V1
  class UsersControllerTest < ActionDispatch::IntegrationTest
    # TODO: Finish this
    # setup do
    #   @user = users(:valid_user)
    # end

    # test 'should get index' do
    #   get v1_users_path, as: :json
    #   assert_response :success
    # end

    # test 'should create user' do
    #   assert_difference('User.count') do
    #     post v1_users_path, params: { user: {
    #       full_name: @user.full_name,
    #       email: @user.email,
    #       password: @user.password,
    #       company_id: @user.company.id,
    #       role: @user.role
    #     } }, as: :json
    #   end

    #   assert_response :created
    # end

    # test 'should show user' do
    #   get v1_users_path(@user), as: :json
    #   assert_response :success
    # end

    # test 'should update user' do
    #   patch v1_users_path(@user), params: { user: {
    #     full_name: @user.full_name,
    #     email: @user.email,
    #     password: @user.password,
    #     company_id: @user.company.id,
    #     role: @user.role
    #   } }, as: :json
    #   assert_response :success
    # end

    # test 'should destroy user' do
    #   assert_difference('User.count', -1) do
    #     delete v1_users_path(@user), as: :json
    #   end

    #   assert_response :no_content
    # end

    should rescue_from(StandardError)
      .with(:render_exception)

    should route(:get, 'v1/users')
      .to(controller: :'v1/users', action: :index)
    should route(:get, 'v1/users/1')
      .to(controller: :'v1/users', action: :show, id: 1)
    should route(:post, 'v1/users')
      .to(controller: :'v1/users', action: :create)
    should route(:put, 'v1/users/1')
      .to(controller: :'v1/users', action: :update, id: 1)
    should route(:delete, 'v1/users/1')
      .to(controller: :'v1/users', action: :destroy, id: 1)

    should use_before_action(:find_user)
    should use_before_action(:set_user)
  end
end
