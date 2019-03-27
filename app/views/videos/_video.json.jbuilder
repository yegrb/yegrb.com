json.extract! video, :id, :link, :title, :speaker, :user_id, :created_at, :updated_at
json.url video_url(video, format: :json)
