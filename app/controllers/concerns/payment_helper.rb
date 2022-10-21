module PaymentHelper
  def find_company
    if @current_user.role.eql?('admin')
      Company.find_by(nit: params[:payroll][:company_nit])
    else
      @current_user.company
    end
  end

  def remunerate
    find_company.employees.each do |employee|
      Payroll.create(
        employee_id: employee.id,
        period_id: find_company.periods.last.id
      )
    end
    @payrolls = find_company.periods.last.payrolls
  end
end
