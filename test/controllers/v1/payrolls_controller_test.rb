require "test_helper"

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll = payrolls(:one)
  end

  test "should get index" do
    get payrolls_url, as: :json
    assert_response :success
  end

  test "should create payroll" do
    assert_difference("Payroll.count") do
      post payrolls_url, params: { payroll: { compensation_fund: @payroll.compensation_fund, deduction: @payroll.deduction, employee_id: @payroll.employee_id, healthcare: @payroll.healthcare, icbf: @payroll.icbf, interest: @payroll.interest, non_salary_income: @payroll.non_salary_income, pension: @payroll.pension, period_id: @payroll.period_id, premium: @payroll.premium, salary_income: @payroll.salary_income, sena: @payroll.sena, severance: @payroll.severance, solidarity_fund: @payroll.solidarity_fund, subsistence_account: @payroll.subsistence_account, transportation: @payroll.transportation, vacation: @payroll.vacation } }, as: :json
    end

    assert_response :created
  end

  test "should show payroll" do
    get payroll_url(@payroll), as: :json
    assert_response :success
  end

  test "should update payroll" do
    patch payroll_url(@payroll), params: { payroll: { compensation_fund: @payroll.compensation_fund, deduction: @payroll.deduction, employee_id: @payroll.employee_id, healthcare: @payroll.healthcare, icbf: @payroll.icbf, interest: @payroll.interest, non_salary_income: @payroll.non_salary_income, pension: @payroll.pension, period_id: @payroll.period_id, premium: @payroll.premium, salary_income: @payroll.salary_income, sena: @payroll.sena, severance: @payroll.severance, solidarity_fund: @payroll.solidarity_fund, subsistence_account: @payroll.subsistence_account, transportation: @payroll.transportation, vacation: @payroll.vacation } }, as: :json
    assert_response :success
  end

  test "should destroy payroll" do
    assert_difference("Payroll.count", -1) do
      delete payroll_url(@payroll), as: :json
    end

    assert_response :no_content
  end
end
