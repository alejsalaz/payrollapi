json.datos do
  json.nombre @user.full_name
  json.correo @user.email
  json.empresa @user.company.legal_name
end
