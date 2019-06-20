# typed: false
require 'test_helper'

class MeetupTest < ActiveSupport::TestCase
  setup do
    @id = 'dgjjmqyzfbdb'
  end

  test 'returns a number when getting rsvp from api' do
    assert_instance_of Integer, Meetup.attending(@id)
  end

  test 'returns a datetime when getting rsvp from api' do
    assert_instance_of ActiveSupport::TimeWithZone, Meetup.time(@id)
  end

  test 'returns a string when getting address from api' do
    assert_instance_of String, Meetup.location(@id)
  end
end
