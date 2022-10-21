# frozen_string_literal: true

require 'test_helper'

module V1
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @token = auth_tokens_for_user(users(:valid_user))
    end

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

    test 'should get index' do
      get '/v1/users', headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    test 'should show user' do
      get "/v1/users/#{users(:valid_user).id}", headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    should use_before_action(:find_user)
    should use_before_action(:set_user)
  end
end
