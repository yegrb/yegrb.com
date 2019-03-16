require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = create(:event)
  end

  test "should get index when not logged in" do
    get events_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_event_url
    assert_redirected_to root_path
  end

  test "shouldn't create event when not logged in" do
    assert_no_difference('Event.count') do
      post events_url, params: { event: { content: @event.content, location: @event.location, signup_link: @event.signup_link, time: @event.time, title: @event.title, user_id: @event.user_id } }
    end

    # assert_redirected_to event_url(Event.last)
    assert_redirected_to root_path
  end

  test "should show event when not logged in" do
    get event_url(@event)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't update event when not logged in" do
    patch event_url(@event), params: { event: { content: @event.content, location: @event.location, signup_link: @event.signup_link, time: @event.time, title: @event.title, user_id: @event.user_id } }
    # assert_redirected_to event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't destroy event when not logged in" do
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end

    assert_redirected_to root_path
    # assert_redirected_to events_url
  end
end
