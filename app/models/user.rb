# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  has_many :events
  has_many :opportunities

  ROLES = ['admin', 'editor', 'user']

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :role, presence: true, inclusion: { in: ROLES, message: '%{value} is not a valid role' }

  # set role to user if blank
  before_validation do |user|
    user.role ||= 'user'
  end

  # Attributes:
  # email:                   string
  # first_name:              string
  # last_name:               string
  # role:                    string
  # created_at, updated_at:  datetime

  def to_s
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def editor?
    role == 'editor'
  end

  def user?
    role == 'user'
  end
end
