# typed: false
require 'test_helper'

class MeetupTest < ActiveSupport::TestCase
  setup do
    @meetup = Meetup.new('dgjjmqyzfbdb')
  end

  test 'returns a number in string form when getting rsvp from api' do
    assert_instance_of String, @meetup.attending
    assert_instance_of Integer, @meetup.attending.to_i
  end

  test 'returns a datetime when getting rsvp from api' do
    assert_instance_of ActiveSupport::TimeWithZone, @meetup.time
  end

  test 'returns a string when getting address from api' do
    assert_instance_of String, @meetup.location
  end
end
