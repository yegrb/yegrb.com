require 'test_helper'

class OpportunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opportunity = create(:opportunity)
    @user = create(:user)
    @editor = create(:editor)
    @admin = create(:admin)
  end

  test 'should get index when not logged in' do
    get opportunities_url
    assert_response :success
    get opportunities_url(collection: 'open')
    assert_response :success
    get opportunities_url(collection: 'closed')
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_opportunity_url
    assert_redirected_to root_path
  end

  test 'should get new when logged in' do
    log_in @user
    get new_opportunity_url
    assert_response :success
  end

  test 'should get new when logged in as editor' do
    log_in @editor
    get new_opportunity_url
    assert_response :success
  end

  test 'should get new when logged in as admin' do
    log_in @admin
    get new_opportunity_url
    assert_response :success
  end

  test "shouldn't create opportunity when not logged in" do
    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: {
        company: @opportunity.company,
        contact: @opportunity.contact,
        content: @opportunity.content,
        email: @opportunity.email,
        good_until: @opportunity.good_until,
        paid_position: @opportunity.paid_position,
        title: @opportunity.title
      } }
    end

    # assert_redirected_to opportunity_url(Opportunity.last)
    assert_redirected_to root_path
  end

  test "shouldn't create opportunity when good until is 4 months in the future" do
    log_in @opportunity.user
    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: {
        company: @opportunity.company,
        contact: @opportunity.contact,
        content: @opportunity.content,
        email: @opportunity.email,
        good_until: Time.zone.now + 120.days,
        paid_position: @opportunity.paid_position,
        title: @opportunity.title
      } }
    end
    assert_response :success
  end

  test 'should create opportunity when logged in as user' do
    log_in @opportunity.user
    assert_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: {
        company: @opportunity.company,
        contact: @opportunity.contact,
        content: @opportunity.content,
        email: Faker::Internet.email,
        good_until: @opportunity.good_until,
        paid_position: @opportunity.paid_position,
        title: @opportunity.title
      } }
    end

    assert_redirected_to opportunity_url(Opportunity.last)
  end

  test 'should close opportunity when logged in as user' do
    log_in @opportunity.user
    post close_opportunity_url(@opportunity)
    @opportunity.reload
    assert @opportunity.closed?

    assert_redirected_to opportunity_url(Opportunity.last)
  end

  test 'shouldn\'t close opportunity when logged in as other user' do
    log_in @user
    post close_opportunity_url(@opportunity)
    @opportunity.reload
    assert_not @opportunity.closed?
  end

  test 'should create opportunity when logged in as editor' do
    log_in @editor
    assert_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: {
        company: @opportunity.company,
        contact: @opportunity.contact,
        content: @opportunity.content,
        email: Faker::Internet.email,
        good_until: @opportunity.good_until,
        paid_position: @opportunity.paid_position,
        title: @opportunity.title
      } }
    end

    assert_redirected_to opportunity_url(Opportunity.last)
  end

  test 'should create opportunity when logged in as admin' do
    log_in @admin
    assert_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: {
        company: @opportunity.company,
        contact: @opportunity.contact,
        content: @opportunity.content,
        email: Faker::Internet.email,
        good_until: @opportunity.good_until,
        paid_position: @opportunity.paid_position,
        title: @opportunity.title
      } }
    end

    assert_redirected_to opportunity_url(Opportunity.last)
  end

  test 'should show opportunity when not logged in' do
    get opportunity_url(@opportunity)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_opportunity_url(@opportunity)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when logged in as a different user" do
    log_in @user
    get edit_opportunity_url(@opportunity)
    assert_redirected_to root_path
  end

  test 'should get edit when logged in as authoring user' do
    log_in @opportunity.user
    get edit_opportunity_url(@opportunity)
    assert_response :success
  end

  test 'should get edit when logged in as editor' do
    log_in @editor
    get edit_opportunity_url(@opportunity)
    assert_response :success
  end

  test 'should get edit when logged in as admin' do
    log_in @admin
    get edit_opportunity_url(@opportunity)
    assert_response :success
  end

  test "shouldn't update opportunity when not logged in" do
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: @opportunity.good_until,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_not_equal 'NEWTITLE', @opportunity.title
    # assert_redirected_to opportunity_url(@opportunity)
    assert_redirected_to root_path
  end

  test "shouldn't update opportunity when different user" do
    log_in @user
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: @opportunity.good_until,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_not_equal 'NEWTITLE', @opportunity.title
    # assert_redirected_to opportunity_url(@opportunity)
    assert_redirected_to root_path
  end

  test 'should update opportunity when authoring user' do
    log_in @opportunity.user
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: @opportunity.good_until,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_equal 'NEWTITLE', @opportunity.title
    assert_redirected_to opportunity_url(@opportunity)
  end

  test 'shouldn\'t update opportunity when authoring user and good_until is greater than 90 days' do
    log_in @opportunity.user
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: 91.days.from_now,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_not_equal 'NEWTITLE', @opportunity.title
    assert_response :success
  end

  test 'should update opportunity when editor' do
    log_in @editor
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: @opportunity.good_until,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_equal 'NEWTITLE', @opportunity.title
    assert_redirected_to opportunity_url(@opportunity)
  end

  test 'should update opportunity when admin' do
    log_in @admin
    patch opportunity_url(@opportunity), params: { opportunity: {
      company: @opportunity.company,
      contact: @opportunity.contact,
      content: @opportunity.content,
      email: @opportunity.email,
      good_until: @opportunity.good_until,
      paid_position: @opportunity.paid_position,
      title: 'NEWTITLE'
    } }
    @opportunity.reload
    assert_equal 'NEWTITLE', @opportunity.title
    assert_redirected_to opportunity_url(@opportunity)
  end

  test "shouldn't destroy opportunity when not logged in" do
    assert_no_difference('Opportunity.count') do
      delete opportunity_url(@opportunity)
    end

    # assert_redirected_to opportunities_url
    assert_redirected_to root_path
  end

  test "shouldn't destroy opportunity when different user" do
    log_in @user
    assert_no_difference('Opportunity.count') do
      delete opportunity_url(@opportunity)
    end

    # assert_redirected_to opportunities_url
    assert_redirected_to root_path
  end

  test 'should destroy opportunity when authoring user' do
    log_in @opportunity.user
    assert_difference('Opportunity.count', -1) do
      delete opportunity_url(@opportunity)
    end

    assert_redirected_to opportunities_url
  end

  test 'should destroy opportunity when editor' do
    log_in @editor
    assert_difference('Opportunity.count', -1) do
      delete opportunity_url(@opportunity)
    end

    assert_redirected_to opportunities_url
  end

  test 'should destroy opportunity when admin' do
    log_in @admin
    assert_difference('Opportunity.count', -1) do
      delete opportunity_url(@opportunity)
    end

    assert_redirected_to opportunities_url
  end
end
