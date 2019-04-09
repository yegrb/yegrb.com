class Meetup
  require 'rest-client'

  URLNAME = 'startupedmonton'
  HOST = 'https://api.meetup.com/'

  class << self
    def attending(id)
      get(id).yes_rsvp_count
    end

    def time(id)
      Time.at(get(id).time / 1000)
    end

    def location(id)
      venue = get(id).venue
      "#{venue.name}: #{venue.address_1}, #{venue.city}, #{venue.state}"
    end

    def get(id)
      Rails.cache.fetch(
        "meetup_#{id}",
        expires_in: rand(5).minutes,
        race_condition_ttl: 30.seconds
      ) do
        puts 'event not cached'
        response = RestClient.get "#{HOST}#{URLNAME}/events/#{id}"
        JSON.parse(response, object_class: OpenStruct)
      end
    end
  end
end
