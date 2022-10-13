json.extract! employee, :id, :card_id, :company_id, :full_name, :contract_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
