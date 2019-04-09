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
#  meetup_id   :string
#  user_id     :integer
#

class Event < ApplicationRecord
  belongs_to :user

  STARTUP_URL = %r{https://www.meetup.com/startupedmonton/events/([a-zA-Z0-9]+)}

  validates :user_id, :content, :title, presence: true
  validates :time, :location,
            presence: { message: 'needs to be present if no Meetup link is entered' },
            unless: proc { |e| e.signup_link.present? && STARTUP_URL =~ e.signup_link }

  before_save :set_meetup_id

  def set_meetup_id
    self.meetup_id = if signup_link.present? && STARTUP_URL =~ signup_link
                       STARTUP_URL.match(signup_link)[1]
                     end
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def nice_time
    (time || Meetup.time(meetup_id)).strftime('%A, %d %b %Y %l:%M %p')
  end

  def nice_location
    location || Meetup.location(meetup_id)
  end

  def attending
    return 'Unknown' if meetup_id.blank?

    Meetup.attending(meetup_id)
  end
end
