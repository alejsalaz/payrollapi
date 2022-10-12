# frozen_string_literal: true

require 'test_helper'

module V1
  class CompaniesControllerTest < ActionDispatch::IntegrationTest
    should rescue_from(StandardError)
      .with(:render_exception)

    should route(:get, 'v1/companies')
      .to(controller: :'v1/companies', action: :index)
    should route(:get, 'v1/companies/1')
      .to(controller: :'v1/companies', action: :show, id: 1)
    should route(:post, 'v1/companies')
      .to(controller: :'v1/companies', action: :create)
    should route(:put, 'v1/companies/1')
      .to(controller: :'v1/companies', action: :update, id: 1)
    should route(:delete, 'v1/companies/1')
      .to(controller: :'v1/companies', action: :destroy, id: 1)

    should use_before_action(:find_company)
    should use_before_action(:set_company)
  end
end
