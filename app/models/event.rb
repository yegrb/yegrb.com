# typed: true
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
  extend T::Sig

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
            unless: proc { |event| event.url.present? && STARTUP_URL =~ event.url }

  before_save :set_attributes

  scope :sorted, -> { order('time DESC') }
  scope :upcoming, lambda {
    where('time > ?', Time.zone.now).order('time ASC')
  }
  scope :past, lambda {
    where('time < ?', Time.zone.now).order('time DESC')
  }

  sig { void }
  def set_attributes
    self.meetup_id ||= STARTUP_URL.match(url)[1] if good_url?
    return if meetup_id.blank?

    self.time = meetup.time
    self.location = meetup.location
  end

  def meetup
    @meetup ||= Meetup.new(meetup_id)
  end

  sig { returns(String) }
  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  sig { returns(String) }
  def to_s
    title
  end

  sig { returns(String) }
  def nice_time
    T.must(time).strftime('%A, %d %b %Y %l:%M %p')
  end

  sig { returns(T::Boolean) }
  def good_url?
    url.present? && STARTUP_URL.match?(url)
  end

  sig { returns(String) }
  def attending
    meetup.attending
  end

  sig { returns(String) }
  def google_map
    parameters = T.must(location).scan(/[a-zA-Z0-9]*/).reject(&:blank?).join('+')
    'https://www.google.com/maps/search/?api=1&query=' + parameters
  end

  sig { returns(T::Boolean) }
  def upcoming?
    T.must(time) > Time.zone.now
  end

  sig { returns(T::Boolean) }
  def can_rsvp?
    upcoming? && url.present?
  end

  sig { returns(T::Boolean) }
  def past?
    T.must(time) <= Time.zone.now
  end
end
