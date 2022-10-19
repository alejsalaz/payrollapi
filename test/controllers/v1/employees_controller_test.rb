require 'test_helper'

module V1
  class EmployeesControllerTest < ActionDispatch::IntegrationTest
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

    should use_before_action(:find_employee)
    should use_before_action(:set_employee)
  end
end
