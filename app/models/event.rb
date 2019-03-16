class Event < ApplicationRecord
  belongs_to :user

  # Attributes
  # user_id:                integer
  # title:                  string
  # time:                   datetime
  # location:               string
  # signup_link:            string
  # content:                text
  # created_at, updated_at: datetime
  
end
