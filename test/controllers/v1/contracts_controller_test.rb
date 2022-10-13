require "test_helper"

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url, as: :json
    assert_response :success
  end

  test "should create contract" do
    assert_difference("Contract.count") do
      post contracts_url, params: { contract: { base_salary: @contract.base_salary, employee_id: @contract.employee_id, job_title: @contract.job_title, start_date: @contract.start_date, termination_date: @contract.termination_date, type: @contract.type } }, as: :json
    end

    assert_response :created
  end

  test "should show contract" do
    get contract_url(@contract), as: :json
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { base_salary: @contract.base_salary, employee_id: @contract.employee_id, job_title: @contract.job_title, start_date: @contract.start_date, termination_date: @contract.termination_date, type: @contract.type } }, as: :json
    assert_response :success
  end

  test "should destroy contract" do
    assert_difference("Contract.count", -1) do
      delete contract_url(@contract), as: :json
    end

    assert_response :no_content
  end
end
