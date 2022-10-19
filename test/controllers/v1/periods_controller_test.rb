require 'test_helper'

module V1
  class PeriodsControllerTest < ActionDispatch::IntegrationTest
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

    should use_before_action(:find_period)
    should use_before_action(:set_period)
  end
end
