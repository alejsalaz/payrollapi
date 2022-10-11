json.datos do
  json.id @user.id if @current_user.role.eql?('admin')
  json.nombre @user.full_name
  json.correo @user.email
  json.empresa @user.company.legal_name
  json.rol @user.role
end
