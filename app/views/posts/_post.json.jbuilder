json.extract! post, :id, :user_id, :title, :time, :location, :signup_link, :meetup_description, :content, :additional_information, :thank_you, :created_at, :updated_at
json.url post_url(post, format: :json)
