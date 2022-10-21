require 'test_helper'

module V1
  class PeriodsControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @token = auth_tokens_for_user(users(:valid_user))
    end

    should rescue_from(StandardError)
      .with(:render_exception)

    should route(:get, 'v1/periods')
      .to(controller: :'v1/periods', action: :index)
    should route(:get, 'v1/periods/1')
      .to(controller: :'v1/periods', action: :show, id: 1)
    should route(:post, 'v1/periods')
      .to(controller: :'v1/periods', action: :create)
    should route(:put, 'v1/periods/1')
      .to(controller: :'v1/periods', action: :update, id: 1)
    should route(:delete, 'v1/periods/1')
      .to(controller: :'v1/periods', action: :destroy, id: 1)

    test 'should get index' do
      get '/v1/periods', headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    test 'should show period' do
      get "/v1/periods/#{users(:valid_user).company.periods.first.id}", headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    should use_before_action(:find_period)
    should use_before_action(:set_period)
  end
end
