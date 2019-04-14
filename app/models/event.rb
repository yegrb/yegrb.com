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

  validates :user_id, :content, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :time, :location,
            presence: { message: 'needs to be present if no Meetup link is entered' },
            unless: proc { |e| e.signup_link.present? && STARTUP_URL =~ e.signup_link }

  before_save :set_attributes

  scope :sorted, -> { order('created_at DESC').includes(:user) }
  scope :upcoming, -> { sorted.where('time > ?', Time.zone.now) }
  scope :past, -> { sorted.where('time < ?', Time.zone.now) }

  def set_attributes
    self.meetup_id ||= if signup_link.present? && STARTUP_URL =~ signup_link
                         STARTUP_URL.match(signup_link)[1]
                       end
    return if meetup_id.blank?

    self.time = Meetup.time(meetup_id)
    self.location = Meetup.location(meetup_id)
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
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
    upcoming? && signup_link.present?
  end

  def past?
    time <= Time.zone.now
  end
end
