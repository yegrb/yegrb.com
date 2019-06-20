# typed: false
require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invite = create(:invite)
    @user = create(:user)
    @editor = create(:editor)
    @admin = create(:admin)
  end

  test "shouldn't get index when not logged in" do
    get invites_url
    assert_redirected_to root_path
  end

  test "shouldn't get index when user" do
    log_in @user
    get invites_url
    assert_redirected_to root_path
  end

  test 'should get index when editor' do
    log_in @editor
    get invites_url
    assert_response :success
  end

  test 'should get index when admin' do
    log_in @admin
    get invites_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_invite_url
    assert_redirected_to root_path
  end

  test "shouldn't get new when user" do
    log_in @user
    get new_invite_url
    assert_redirected_to root_path
  end

  test 'should get new when editor' do
    log_in @editor
    get new_invite_url
    assert_response :success
  end

  test 'should get new when admin' do
    log_in @admin
    get new_invite_url
    assert_response :success
  end

  test "shouldn't create invite when not logged in" do
    assert_no_difference('Invite.count') do
      post invites_url, params: { invite: { code: @invite.code, email: @invite.email,
                                            expiry: @invite.expiry, name: @invite.name, user_id: @invite.user_id } }
    end

    # assert_redirected_to invite_url(Invite.last)
    assert_redirected_to root_path
  end

  test "shouldn't create invite when user" do
    log_in @user
    assert_no_difference('Invite.count') do
      post invites_url, params: { invite: { code: @invite.code, email: @invite.email,
                                            expiry: @invite.expiry, name: @invite.name, user_id: @invite.user_id } }
    end

    # assert_redirected_to invite_url(Invite.last)
    assert_redirected_to root_path
  end

  test 'editor can invite users' do
    log_in @editor
    assert_difference('Invite.count') do
      post invites_url, params: { invite: {
        email: Faker::Internet.unique.email,
        name: @invite.name,
        role: 'user'
      } }
    end

    assert_redirected_to invite_url(Invite.last)
  end

  test 'editor cannot invite editors' do
    log_in @editor
    assert_no_difference('Invite.count') do
      post invites_url, params: { invite: {
        email: Faker::Internet.unique.email,
        name: @invite.name,
        role: 'editor'
      } }
    end
  end

  test 'editor cannot invite admins' do
    log_in @editor
    assert_no_difference('Invite.count') do
      post invites_url, params: { invite: {
        email: Faker::Internet.unique.email,
        name: @invite.name,
        role: 'admin'
      } }
    end
  end

  test 'should create invite when admin' do
    log_in @admin
    assert_difference('Invite.count') do
      post invites_url, params: { invite: { email: Faker::Internet.unique.email,
                                            name: @invite.name, role: 'admin' } }
    end

    last_invite = Invite.last
    assert_not_nil last_invite.code
    assert_not_nil last_invite.expiry
    assert_redirected_to invite_url(last_invite)
  end

  test "shouldn't destroy invite when not logged in" do
    assert_no_difference('Invite.count') do
      delete invite_url(@invite)
    end

    # assert_redirected_to invites_url
    assert_redirected_to root_path
  end

  test "shouldn't destroy invite when logged in as user" do
    log_in @user
    assert_no_difference('Invite.count') do
      delete invite_url(@invite)
    end

    # assert_redirected_to invites_url
    assert_redirected_to root_path
  end

  test 'should destroy invite when logged in as editor' do
    log_in @editor
    assert_difference('Invite.count', -1) do
      delete invite_url(@invite)
    end

    assert_redirected_to invites_url
  end

  test 'should destroy invite when logged in as admin' do
    log_in @admin
    assert_difference('Invite.count', -1) do
      delete invite_url(@invite)
    end

    assert_redirected_to invites_url
  end
end
