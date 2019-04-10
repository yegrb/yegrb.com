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
  belongs_to :user

  validates :user_id, :title, :contact, :paid_position, presence: true
  validate :good_until_within_time
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: User::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :content, presence: true, length: { maximum: 1000 }

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
end
