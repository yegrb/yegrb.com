# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  content    :text
#  location   :string
#  time       :datetime
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meetup_id  :string
#  user_id    :integer
#

class Event < ApplicationRecord
  belongs_to :user
  has_many :videos

  STARTUP_URL = %r{https://www.meetup.com/startupedmonton/events/([a-zA-Z0-9]+)}
  DATEPICKER_JS = {
    format: 'YYYY-MM-DD HH:mm',
    showTodayButton: true,
    icons: {
      time: 'fa fa-clock-o',
      date: 'fa fa-calendar',
      up: 'fa fa-arrow-up',
      down: 'fa fa-arrow-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-calendar-check-o',
      clear: 'fa fa-delete',
      close: 'fa fa-times'
    }
  }

  validates :user_id, presence: true
  validates :content, presence: true, length: { within: 20..1000 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, :location,
            presence: { message: 'needs to be present if no Meetup link is entered' },
            unless: proc { |e| e.url.present? && STARTUP_URL =~ e.url }

  before_save :set_attributes

  scope :sorted, -> { order('time DESC').includes(:user) }
  scope :upcoming, lambda {
    where('time > ?', Time.zone.now).order('time ASC').includes(:user)
  }
  scope :past, lambda {
    where('time < ?', Time.zone.now).order('time DESC').includes(:user)
  }

  def set_attributes
    self.meetup_id ||= if url.present? && STARTUP_URL =~ url
                         STARTUP_URL.match(url)[1]
                       end
    return if meetup_id.blank?

    self.time = Meetup.time(meetup_id)
    self.location = Meetup.location(meetup_id)
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def to_s
    title
  end

  def nice_time
    time.strftime('%A, %d %b %Y %l:%M %p')
  end

  def attending
    return 'Unknown' if meetup_id.blank?

    Meetup.attending(meetup_id)
  end

  def google_map
    parameters = location.scan(/[a-zA-Z0-9]*/).reject(&:blank?).join('+')
    'https://www.google.com/maps/search/?api=1&query=' + parameters
  end

  def upcoming?
    time > Time.zone.now
  end

  def can_rsvp?
    upcoming? && url.present?
  end

  def past?
    time <= Time.zone.now
  end
end
