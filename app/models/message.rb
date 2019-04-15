require 'mailgun-ruby'

class Message
  include ActiveModel::Model
  attr_accessor :name, :email, :body

  validates :name, :email, :body, presence: true

  def send_it
    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
    info = {
      from: email,
      to: 'alanvardy@gmail.com',
      subject: "Email from #{name} - YEGRB.com",
      text: "From: #{name}\nEmail: #{email}\n\n #{body}"
    }
    mg_client.send_message 'mg.vardy.codes', info
  end
end
