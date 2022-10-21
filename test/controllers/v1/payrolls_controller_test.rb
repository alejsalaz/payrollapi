require 'test_helper'

module V1
  class PayrollsControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @token = auth_tokens_for_user(users(:valid_user))
      @payroll = payrolls(:valid_payroll)
    end

    should rescue_from(StandardError)
      .with(:render_exception)

    should route(:get, 'v1/payrolls')
      .to(controller: :'v1/payrolls', action: :index)
    should route(:get, 'v1/payrolls/1')
      .to(controller: :'v1/payrolls', action: :show, id: 1)
    should route(:post, 'v1/payrolls')
      .to(controller: :'v1/payrolls', action: :create)
    should route(:put, 'v1/payrolls/1')
      .to(controller: :'v1/payrolls', action: :update, id: 1)
    should route(:delete, 'v1/payrolls/1')
      .to(controller: :'v1/payrolls', action: :destroy, id: 1)

    test 'should get index' do
      get '/v1/payrolls', headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    test 'should show payroll' do
      get "/v1/payrolls/#{@payroll.id}", headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    should use_before_action(:find_payroll)
  end
end
