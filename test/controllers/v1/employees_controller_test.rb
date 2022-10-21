require 'test_helper'

module V1
  class EmployeesControllerTest < ActionDispatch::IntegrationTest
    include AuthorizationHelper

    setup do
      @token = auth_tokens_for_user(users(:valid_user))
      @employee = employees(:valid_employee)
    end

    should rescue_from(StandardError)
      .with(:render_exception)

    should route(:get, 'v1/employees')
      .to(controller: :'v1/employees', action: :index)
    should route(:get, 'v1/employees/1')
      .to(controller: :'v1/employees', action: :show, id: 1)
    should route(:post, 'v1/employees')
      .to(controller: :'v1/employees', action: :create)
    should route(:put, 'v1/employees/1')
      .to(controller: :'v1/employees', action: :update, id: 1)
    should route(:delete, 'v1/employees/1')
      .to(controller: :'v1/employees', action: :destroy, id: 1)

    test 'should get index' do
      get '/v1/employees', headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    test 'should show employee' do
      get "/v1/employees/#{@employee.card_id}", headers: {
        Authorization: @token
      }, as: :json
      assert_response :success
    end

    should use_before_action(:find_employee)
    should use_before_action(:set_employee)
  end
end
