require 'test_helper'

class UsersSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end
  test "should get login" do
    get new_user_session_path
    assert_response :success
  end

  test 'should log in user with correct password' do
    post user_session_path, params: { user: {email: @user.email, password: @user.password}}
    assert_redirected_to root_path
  end

  test 'shouldn\'t log in user with incorrect password' do
    post user_session_path, params: { user: {email: @user.email, password: 'nottherightpassword'}}
    assert_response :success
  end
end
