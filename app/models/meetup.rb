# typed: true

class Meetup
  require 'rest-client'
  extend T::Sig

  URLNAME = 'startupedmonton'
  HOST = 'https://api.meetup.com/'

  def initialize(id)
    @payload = id.blank? ? nil : get(id)
  end

  sig { returns(String) }
  def attending
    return 'Unknown' unless @payload

    @payload.yes_rsvp_count.to_s
  end

  sig { returns(ActiveSupport::TimeWithZone) }
  def time
    Time.zone.at(@payload.time / 1000)
  end

  sig { returns(String) }
  def location
    return 'Unknown' unless @payload

    venue = @payload.venue
    "#{venue.name}: #{venue.address_1}, #{venue.city}, #{venue.state}"
  end

  private

  sig { params(id: String).returns(OpenStruct) }
  def get(id)
    Rails.cache.fetch(
      "meetup_#{id}",
      expires_in: rand(5).minutes,
      race_condition_ttl: 30.seconds
    ) do
      response = RestClient.get "#{HOST}#{URLNAME}/events/#{id}"
      JSON.parse(response, object_class: OpenStruct)
    end
  end
end
