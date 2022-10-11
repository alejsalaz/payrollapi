json.error do
  json.problema @errors.full_messages[0]
  json.referencia @errors.details.first[1][0][:code] if @errors.details.first[1][0][:code]
end
