json.extract! expenditure, :id, :date, :name, :reference, :description, :amount, :category, :created_at, :updated_at
json.url expenditure_url(expenditure, format: :json)
