require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @user2 = create(:user)
    @admin = create(:admin)
    @editor = create(:editor)
    @invite = create(:invite)
  end

  test "shouldn't get index if not logged in" do
    get users_url
    assert_redirected_to root_path
  end

  test "should get index if editor" do
    log_in @editor
    get users_url
    assert_response :success
  end

  test "should get index if admin" do
    log_in @admin
    get users_url
    assert_response :success
  end

  test "should get new with invite code" do
    get new_user_url(code: @invite.code)
    assert_response :success
  end

  test "shouldn't get new without invite code" do
    get new_user_url
    assert_redirected_to root_path
  end

  test "should create user if email and code match invite" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @invite.email,
                                        code: @invite.code,
                                        first_name: @user.first_name,
                                        last_name: @user.last_name,
                                        role: @invite.role,
                                        password: 'password',
                                        password_confirmation: 'password' } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "shouldn't create user if code doesn't match" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @invite.email,
                                        code: Faker::Crypto.unique.md5,
                                        first_name: @user.first_name,
                                        last_name: @user.last_name,
                                        role: @invite.role,
                                        password: 'password',
                                        password_confirmation: 'password' } }
    end

    assert_redirected_to root_path
  end

  test "shouldn't show user if not logged in" do
    get user_url(@user)
    assert_redirected_to root_path
  end

  test "shouldn't show user if different user" do
    log_in @user2
    get user_url(@user)
    assert_redirected_to root_path
  end

  test "should show user if same user" do
    log_in @user
    get user_url(@user)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_user_url(@user)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when different user" do
    log_in @user2
    get edit_user_url(@user)
    assert_redirected_to root_path
  end

  test "shouldn't get edit when editor" do
    log_in @editor
    get edit_user_url(@user)
    assert_redirected_to root_path
  end

  test "should get edit when same user" do
    log_in @user
    get edit_user_url(@user)
    assert_response :success
  end

  test "should get edit when admin" do
    log_in @admin
    get edit_user_url(@user)
    assert_response :success
  end

  test "shouldn't update user when not logged in" do
    patch user_url(@user), params: { user:
    {
      email: @user.email,
      first_name: @user.first_name,
      last_name: @user.last_name,
      role: @user.role
    } }
    assert_redirected_to root_path
  end

  test "shouldn't update user when different user" do
    log_in @user2
    patch user_url(@user), params: { user:
    {
      email: @user.email,
      first_name: @user.first_name,
      last_name: @user.last_name,
      role: @user.role
    } }
    assert_redirected_to root_path
  end

  test "shouldn't update user when editor" do
    log_in @user2
    patch user_url(@user), params: { user:
    {
      email: @user.email,
      first_name: @user.first_name,
      last_name: @user.last_name,
      role: @user.role
    } }
    assert_redirected_to root_path
  end

  test "should update user when same user" do
    log_in @user
    patch user_url(@user), params: { user:
    {
      email: @user.email,
      first_name: @user.first_name,
      last_name: @user.last_name,
      role: @user.role
    } }
    assert_redirected_to user_url(@user)
  end

  test "should update user when admin" do
    log_in @admin
    patch user_url(@user), params: { user:
    {
      email: @user.email,
      first_name: @user.first_name,
      last_name: @user.last_name,
      role: @user.role
    } }
    assert_redirected_to user_url(@user)
  end

  test "shouldn't destroy user when not logged in" do
    assert_no_difference('User.count') do
      delete user_url(@user)
    end

    # assert_redirected_to users_url
    assert_redirected_to root_path
  end

  test "shouldn't destroy user when other user" do
    log_in @user2
    assert_no_difference('User.count') do
      delete user_url(@user)
    end

    # assert_redirected_to users_url
    assert_redirected_to root_path
  end

  test "shouldn't destroy user when editor" do
    log_in @editor
    assert_no_difference('User.count') do
      delete user_url(@user)
    end

    # assert_redirected_to users_url
    assert_redirected_to root_path
  end

  test "should destroy user when user" do
    log_in @user
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should destroy user when admin" do
    log_in @admin
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
