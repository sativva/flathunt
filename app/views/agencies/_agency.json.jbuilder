json.extract! agency, :id, :name, :mail, :address, :postal, :phone, :url, :logo, :created_at, :updated_at
json.url agency_url(agency, format: :json)