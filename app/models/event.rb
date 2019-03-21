# == Schema Information
#
# Table name: events
#
#  id          :bigint(8)        not null, primary key
#  content     :text
#  location    :string
#  signup_link :string
#  time        :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

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

  validates :user_id, :content, :title, presence: true
end
