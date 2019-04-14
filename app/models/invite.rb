# == Schema Information
#
# Table name: invites
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  email      :string
#  expiry     :datetime
#  name       :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Invite < ApplicationRecord
  belongs_to :user
  before_save :set_attributes

  validates :name, presence: true, length: { maximum: 50 }
  validates :role, presence: true, inclusion: { in: User::ROLES }
  validates :user_id, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: User::VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validate :only_admin_can_create_editors_and_admins

  def only_admin_can_create_editors_and_admins
    return unless ['editor', 'admin'].include? role

    errors.add(:role, 'must be Admin to grant') unless user.admin?
  end

  def set_attributes
    self.code ||= Digest::SHA1.hexdigest(email)
    self.expiry ||= Time.zone.now + 1.week
  end

  def expired?
    expiry < Time.zone.now
  end

  def nice_expiry
    if expired?
      "Expired: #{expiry.strftime('%d %b %Y')}"
    else
      "Expires: #{expiry.strftime('%d %b %Y')}"
    end
  end

  def nice_user
    return 'Removed' unless user&.full_name

    "Invited by: #{user&.full_name}"
  end

end
