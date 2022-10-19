json.data do
  json.id @period.id if %w[admin accountant].include?(@current_user.role)
  json.empresa Company.find_by(id: @period.company_id).legal_name
  json.fecha_inicio @period.start_date
  json.fecha_fin @period.end_date
  json.estado translate("views.periods.#{@period.state}")
end
