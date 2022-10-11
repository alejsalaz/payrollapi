json.data @companies do |company|
  json.nit company.nit
  json.nombre company.legal_name
  json.comercial company.display_name
end
