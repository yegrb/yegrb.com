# typed: true
require 'mailgun-ruby'

class Message
  extend T::Sig

  include ActiveModel::Model
  attr_accessor :name, :email, :body

  validates :name, :body, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: User::VALID_EMAIL_REGEX }

  sig { void }
  def send_it
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    info = {
      from: email,
      to: 'contact@mail.yegrb.com',
      subject: "Email from #{name} - YEGRB.com",
      text: "From: #{name}\nEmail: #{email}\n\n #{body}"
    }
    mg_client.send_message 'mail.yegrb.com', info
  end
end
