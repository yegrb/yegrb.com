# typed: false
# == Schema Information
#
# Table name: opportunities
#
#  id            :bigint(8)        not null, primary key
#  company       :string
#  contact       :string
#  content       :text
#  email         :string
#  good_until    :datetime
#  paid_position :boolean
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

class Opportunity < ApplicationRecord
  GOOD_UNTIL_MAX_DAYS = 90
  DATEPICKER_JS = {
    format: 'YYYY-MM-DD',
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
  belongs_to :user

  validates :user_id, :title, :contact, :good_until, presence: true
  validates :paid_position, inclusion: { in: [true, false] }
  validate :good_until_within_time
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: User::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :content, presence: true, length: { maximum: 1000 }

  scope :sorted, -> { order('created_at DESC') }
  scope :open, -> { sorted.where('good_until > ?', Time.zone.now) }
  scope :closed, -> { sorted.where('good_until <= ?', Time.zone.now) }

  before_save { self.email = email.downcase }

  def good_until_within_time
    return true if Time.zone.now + GOOD_UNTIL_MAX_DAYS.days >= good_until

    errors.add(:good_until, "must be within #{GOOD_UNTIL_MAX_DAYS} days of today")
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def nice_good_until
    good_until.strftime('%d %b %Y')
  end

  def closed?
    Time.zone.now >= good_until
  end

  def close!
    return false if closed?

    update(good_until: Time.zone.now)
  end
end
