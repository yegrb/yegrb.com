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
  belongs_to :user

  validates :user_id, :title, :content, :contact, :paid_position, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: User::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  def nice_good_until
    good_until.strftime('%d %b %Y')
  end
end
