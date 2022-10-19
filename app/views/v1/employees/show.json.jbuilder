json.datos do
  json.nombre @employee.full_name
  json.id @employee.id if @current_user.role == 'admin'
  json.empresa @employee.company.legal_name
  json.puesto @employee.job_title
  json.contrato translate("views.employees.#{@employee.contract_type}")
  if %w[admin accountant].include?(@current_user.role)
    json.cedula @employee.card_id
    json.arl @employee.risk_class
    json.salario @employee.base_salary
    json.contratacion @employee.start_date
    json.terminacion @employee.termination_date
  end
end
