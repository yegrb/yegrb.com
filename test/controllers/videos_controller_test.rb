# typed: false
require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = create(:video)
    @user = create(:user)
    @admin = create(:admin)
    @editor = create(:editor)
  end

  test 'should get index when not logged in' do
    get videos_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_video_url
    assert_redirected_to root_path
  end

  test "shouldn't get new when logged in as user" do
    log_in @user
    get new_video_url
    assert_redirected_to root_path
  end

  test 'should get new when logged in as editor' do
    log_in @editor
    get new_video_url
    assert_response :success
  end

  test 'should get new when logged in as admin' do
    log_in @admin
    get new_video_url
    assert_response :success
  end

  test "shouldn't create video when not logged in" do
    assert_no_difference('Video.count') do
      post videos_url, params: { video: {
        recorded_at: @video.recorded_at,
        slides_url: @video.slides_url,
        speaker: @video.speaker,
        speaker_url: @video.speaker_url,
        summary: @video.summary,
        video_url: @video.video_url,
        event_id: @video.event_id,
        title: @video.title,
        runtime: 120
      } }
    end

    # assert_redirected_to video_url(Video.last)
    assert_redirected_to root_path
  end

  test "shouldn't create video when logged in as user" do
    log_in @user
    assert_no_difference('Video.count') do
      post videos_url, params: { video: {
        recorded_at: @video.recorded_at,
        slides_url: @video.slides_url,
        speaker: @video.speaker,
        speaker_url: @video.speaker_url,
        summary: @video.summary,
        video_url: @video.video_url,
        event_id: @video.event_id,
        title: @video.title,
        runtime: 120
      } }
    end

    # assert_redirected_to video_url(Video.last)
    assert_redirected_to root_path
  end

  test 'should create video when logged in as editor' do
    log_in @editor
    assert_difference('Video.count') do
      post videos_url, params: { video: {
        recorded_at: @video.recorded_at,
        slides_url: @video.slides_url,
        speaker: @video.speaker,
        speaker_url: @video.speaker_url,
        summary: @video.summary,
        video_url: @video.video_url,
        event_id: @video.event_id,
        title: @video.title,
        runtime: 120
      } }
    end

    assert_redirected_to video_url(Video.last)
  end

  test 'should create video when logged in as admin' do
    log_in @admin
    assert_difference('Video.count') do
      post videos_url, params: { video: {
        recorded_at: @video.recorded_at,
        slides_url: @video.slides_url,
        speaker: @video.speaker,
        speaker_url: @video.speaker_url,
        summary: @video.summary,
        video_url: @video.video_url,
        event_id: @video.event_id,
        title: @video.title,
        runtime: 120
      } }
    end

    assert_redirected_to video_url(Video.last)
  end

  test 'should show video when not logged in' do
    get video_url(@video)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_video_url(@video)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when logged in as user" do
    log_in @user
    get edit_video_url(@video)
    assert_redirected_to root_path
  end

  test 'should get edit when logged in as editor' do
    log_in @editor
    get edit_video_url(@video)
    assert_response :success
  end

  test 'should get edit when logged in as admin' do
    log_in @admin
    get edit_video_url(@video)
    assert_response :success
  end

  test "shouldn't update video when not logged in" do
    patch video_url(@video), params: { video: {
      recorded_at: @video.recorded_at,
      slides_url: @video.slides_url,
      speaker: @video.speaker,
      speaker_url: @video.speaker_url,
      summary: @video.summary,
      video_url: @video.video_url,
      event_id: @video.event_id,
      title: @video.title,
      runtime: 120
    } }
    # assert_redirected_to video_url(@video)
    assert_redirected_to root_path
  end

  test "shouldn't update video when logged in as user" do
    log_in @user
    patch video_url(@video), params: { video: {
      recorded_at: @video.recorded_at,
      slides_url: @video.slides_url,
      speaker: @video.speaker,
      speaker_url: @video.speaker_url,
      summary: @video.summary,
      video_url: @video.video_url,
      event_id: @video.event_id,
      title: @video.title,
      runtime: 120
    } }
    # assert_redirected_to video_url(@video)
    assert_redirected_to root_path
  end

  test 'should update video when logged in as editor' do
    log_in @editor
    patch video_url(@video), params: { video: {
      recorded_at: @video.recorded_at,
      slides_url: @video.slides_url,
      speaker: @video.speaker,
      speaker_url: @video.speaker_url,
      summary: @video.summary,
      video_url: @video.video_url,
      event_id: @video.event_id,
      title: @video.title,
      runtime: 120
    } }
    assert_redirected_to video_url(@video)
  end

  test 'shouldn\'t update video when logged in as editor and no summary' do
    log_in @editor
    patch video_url(@video), params: { video: {
      recorded_at: @video.recorded_at,
      slides_url: @video.slides_url,
      speaker: @video.speaker,
      speaker_url: @video.speaker_url,
      summary: @video.summary,
      video_url: @video.video_url,
      event_id: @video.event_id,
      title: @video.title,
      runtime: 120
    } }
    @video.reload
    assert_not_equal @video.summary, ''
  end

  test 'should update video when logged in as admin' do
    log_in @admin
    patch video_url(@video), params: { video: {
      recorded_at: @video.recorded_at,
      slides_url: @video.slides_url,
      speaker: @video.speaker,
      speaker_url: @video.speaker_url,
      summary: @video.summary,
      video_url: @video.video_url,
      event_id: @video.event_id,
      title: @video.title,
      runtime: 120
    } }
    assert_redirected_to video_url(@video)
  end

  test "shouldn't destroy video when not logged in" do
    assert_no_difference('Video.count') do
      delete video_url(@video)
    end

    assert_redirected_to root_path
    # assert_redirected_to videos_url
  end

  test "shouldn't destroy video when logged in as user" do
    log_in @user
    assert_no_difference('Video.count') do
      delete video_url(@video)
    end

    assert_redirected_to root_path
    # assert_redirected_to videos_url
  end

  test 'should destroy video when logged in as editor' do
    log_in @editor
    assert_difference('Video.count', -1) do
      delete video_url(@video)
    end

    assert_redirected_to videos_url
  end

  test 'should destroy video when logged in as admin' do
    log_in @admin
    assert_difference('Video.count', -1) do
      delete video_url(@video)
    end

    assert_redirected_to videos_url
  end
  end
