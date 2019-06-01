# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  code            :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  remember_digest :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :events
  has_many :opportunities
  has_many :invites
  has_many :videos
  has_secure_password

  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = ['user', 'editor', 'admin']

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  with_options if: :password_required? do
    validates :password, presence: true
    validates :password_confirmation, presence: true
    validates :password, length: { within: 4..40 }
    validates :password, confirmation: true
  end

  before_save :set_attributes

  def set_attributes
    self.email = email.downcase
  end

  def password_required?
    password_digest.blank? || password.present?
  end

  def user?
    role == 'user'
  end

  def editor?
    role == 'editor'
  end

  def admin?
    role == 'admin'
  end

  def to_s
    first_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  def forget
    update(remember_digest: nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
