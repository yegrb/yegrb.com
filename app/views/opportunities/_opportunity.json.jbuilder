json.extract! opportunity, :id, :user_id, :title, :company, :contact, :email, :paid_position, :content, :good_until, :created_at, :updated_at
json.url opportunity_url(opportunity, format: :json)
