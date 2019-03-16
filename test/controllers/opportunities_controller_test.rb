require 'test_helper'

class OpportunitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @opportunity = create(:opportunity)
  end

  test "should get index when not logged in" do
    get opportunities_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_opportunity_url
    assert_redirected_to root_path
  end

  test "should create opportunity" do
    assert_no_difference('Opportunity.count') do
      post opportunities_url, params: { opportunity: { company: @opportunity.company, contact: @opportunity.contact, content: @opportunity.content, email: @opportunity.email, good_until: @opportunity.good_until, paid_position: @opportunity.paid_position, title: @opportunity.title, user_id: @opportunity.user_id } }
    end

    # assert_redirected_to opportunity_url(Opportunity.last)
    assert_redirected_to root_path
  end

  test "should show opportunity when not logged in" do
    get opportunity_url(@opportunity)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_opportunity_url(@opportunity)
    assert_redirected_to root_path
  end

  test "shouldn't update opportunity when not logged in" do
    patch opportunity_url(@opportunity), params: { opportunity: { company: @opportunity.company, contact: @opportunity.contact, content: @opportunity.content, email: @opportunity.email, good_until: @opportunity.good_until, paid_position: @opportunity.paid_position, title: 'NEWTITLE', user_id: @opportunity.user_id } }
    @opportunity.reload
    assert_not_equal 'NEWTITLE', @opportunity.title
    # assert_redirected_to opportunity_url(@opportunity)
    # assert_redirected_to root_path
  end

  test "shouldn't destroy opportunity" do
    assert_no_difference('Opportunity.count') do
      delete opportunity_url(@opportunity)
    end

    # assert_redirected_to opportunities_url
    assert_redirected_to root_path
  end
end
