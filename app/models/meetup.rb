# typed: true

class Meetup
  require 'rest-client'

  URLNAME = 'startupedmonton'
  HOST = 'https://api.meetup.com/'

  class << self
    extend T::Sig
    sig { params(id: String).returns(Integer) }
    def attending(id)
      get(id).yes_rsvp_count
    end

    sig { params(id: String).returns(ActiveSupport::TimeWithZone) }
    def time(id)
      Time.zone.at(get(id).time / 1000)
    end

    sig { params(id: String).returns(String) }
    def location(id)
      venue = get(id).venue
      "#{T.must(venue).name}: #{T.must(venue).address_1}, #{T.must(venue).city}, #{T.must(venue).state}"
    end

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
end
