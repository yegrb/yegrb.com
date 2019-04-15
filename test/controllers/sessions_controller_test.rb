require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end
  test 'should get login' do
    get login_path
    assert_response :success
  end

  test 'should log in user with correct password' do
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert_redirected_to @user
  end

  test 'shouldn\'t log in user with incorrect password' do
    post login_path, params: { session: { email: @user.email, password: 'nottherightpassword' } }
    assert_response :success
  end

  test 'should log out user' do
    log_in @user
    delete logout_path
    assert_redirected_to root_path
  end
end
