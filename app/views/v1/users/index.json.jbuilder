json.datos @users do |user|
  json.nombre user.full_name
  json.id user.id if @current_user.role == 'admin'
  json.correo user.email
  json.empresa user.company.legal_name
  json.rol user.role
end
