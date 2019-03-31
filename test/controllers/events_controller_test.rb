require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = create(:event)
    @user = create(:user)
    @admin = create(:admin)
    @editor = create(:editor)
  end

  test 'should get index when not logged in' do
    get events_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_event_url
    assert_redirected_to root_path
  end

  test "shouldn't get new when logged in as user" do
    log_in @user
    get new_event_url
    assert_redirected_to root_path
  end

  test 'should get new when logged in as editor' do
    log_in @editor
    get new_event_url
    assert_response :success
  end

  test 'should get new when logged in as admin' do
    log_in @admin
    get new_event_url
    assert_response :success
  end

  test "shouldn't create event when not logged in" do
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        signup_link: @event.signup_link,
        time: @event.time,
        title: @event.title
      } }
    end

    # assert_redirected_to event_url(Event.last)
    assert_redirected_to root_path
  end

  test "shouldn't create event when logged in as user" do
    log_in @user
    assert_no_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        signup_link: @event.signup_link,
        time: @event.time,
        title: @event.title
      } }
    end

    # assert_redirected_to event_url(Event.last)
    assert_redirected_to root_path
  end

  test 'should create event when logged in as editor' do
    log_in @editor
    assert_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        signup_link: @event.signup_link,
        time: @event.time,
        title: @event.title
      } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test 'should create event when logged in as admin' do
    log_in @admin
    assert_difference('Event.count') do
      post events_url, params: { event: {
        content: @event.content,
        location: @event.location,
        signup_link: @event.signup_link,
        time: @event.time,
        title: @event.title
      } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test 'should show event when not logged in' do
    get event_url(@event)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when logged in as user" do
    log_in @user
    get edit_event_url(@event)
    assert_redirected_to root_path
  end

  test 'should get edit when logged in as editor' do
    log_in @editor
    get edit_event_url(@event)
    assert_response :success
  end

  test 'should get edit when logged in as admin' do
    log_in @admin
    get edit_event_url(@event)
    assert_response :success
  end

  test "shouldn't update event when not logged in" do
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      signup_link: @event.signup_link,
      time: @event.time,
      title: @event.title
    } }
    # assert_redirected_to event_url(@event)
    assert_redirected_to root_path
  end

  test "shouldn't update event when logged in as user" do
    log_in @user
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      signup_link: @event.signup_link,
      time: @event.time,
      title: @event.title
    } }
    # assert_redirected_to event_url(@event)
    assert_redirected_to root_path
  end

  test 'should update event when logged in as editor' do
    log_in @editor
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      signup_link: @event.signup_link,
      time: @event.time,
      title: @event.title
    } }
    assert_redirected_to event_url(@event)
  end

  test 'should update event when logged in as admin' do
    log_in @admin
    patch event_url(@event), params: { event: {
      content: @event.content,
      location: @event.location,
      signup_link: @event.signup_link,
      time: @event.time,
      title: @event.title
    } }
    assert_redirected_to event_url(@event)
  end

  test "shouldn't destroy event when not logged in" do
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end

    assert_redirected_to root_path
    # assert_redirected_to events_url
  end

  test "shouldn't destroy event when logged in as user" do
    log_in @user
    assert_no_difference('Event.count') do
      delete event_url(@event)
    end

    assert_redirected_to root_path
    # assert_redirected_to events_url
  end

  test 'should destroy event when logged in as editor' do
    log_in @editor
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  test 'should destroy event when logged in as admin' do
    log_in @admin
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
