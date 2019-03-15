class Opportunity < ApplicationRecord
  belongs_to :user

  # Attributes
  # user_id:                  integer
  # title:                    string
  # company:                  string
  # contact:                  string
  # email:                    string
  # paid_position:            boolean
  # content:                  text
  # good_until:               datetime
  # created_at, updated_at:   datetime


end
