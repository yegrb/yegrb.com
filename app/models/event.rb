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

  validates :user_id, :content, :title, presence: true

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def nice_time
    time.strftime('%A, %d %b %Y %l:%M %p')
  end
end
