require 'test_helper'

module V1
  class PayrollsControllerTest < ActionDispatch::IntegrationTest
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

    should use_before_action(:find_payroll)
  end
end
