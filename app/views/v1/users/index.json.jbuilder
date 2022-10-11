json.error do
  json.mensaje @errors.full_messages[0]
  json.referencia @errors.details.first[1][0][:code]
end
