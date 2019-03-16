json.extract! event, :id, :user_id, :title, :time, :location, :signup_link, :content, :created_at, :updated_at
json.url event_url(event, format: :json)
