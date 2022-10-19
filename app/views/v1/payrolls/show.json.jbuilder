json.nomina do
  json.id @payroll.id if %w[admin accountant].include?(@current_user.role)
  json.empresa @payroll.period.company.legal_name
  json.empleado @payroll.employee.full_name
  json.fecha_inicial @payroll.period.start_date
  json.fecha_final @payroll.period.end_date
  json.dias (@payroll.period.end_date - @payroll.period.start_date).to_i
  json.salario_base @payroll.employee.base_salary
  json.ingresos_salariales @payroll.salary_income
  json.ingresos_no_salariales @payroll.non_salary_income
  json.deducciones @payroll.deduction
  json.auxilio_transporte @payroll.transportation
  json.salud_empleado @payroll.employee_healthcare
  json.pension_empleado @payroll.employee_pension
  json.fondo_solidaridad @payroll.solidarity_fund
  json.cuenta_subsistencia @payroll.subsistence_account
  json.caja_compensacion @payroll.compensation_fund
  json.icbf @payroll.icbf
  json.sena @payroll.sena
  json.cesantias @payroll.severance
  json.intereres @payroll.interest
  json.prima @payroll.premium
  json.vacaciones @payroll.vacation
  json.salud_empleador @payroll.employer_healthcare
  json.pension_empleador @payroll.employer_pension
  json.arl @payroll.arl
  json.pago_empleado (@payroll.employee.base_salary + @payroll.salary_income + @payroll.transportation) -
                     (@payroll.employee_healthcare + @payroll.employee_pension + @payroll.solidarity_fund + @payroll.subsistence_account + @payroll.deduction)
  json.costo_total (@payroll.employee.base_salary + @payroll.salary_income + @payroll.transportation) +
                   (@payroll.employer_healthcare + @payroll.employer_pension + @payroll.arl) +
                   (@payroll.compensation_fund + @payroll.icbf + @payroll.sena) +
                   (@payroll.severance + @payroll.interest + @payroll.premium + @payroll.vacation)
end
