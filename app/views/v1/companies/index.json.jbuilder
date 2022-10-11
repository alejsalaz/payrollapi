json.data @companies do |company|
  json.id company.id if @current_user.role.eql?('admin')
  json.nit company.nit
  json.nombre_legal company.legal_name
  json.nombre_comercial company.display_name if company.display_name
  json.empleados company.users.count
end
