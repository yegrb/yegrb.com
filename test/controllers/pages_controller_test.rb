require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    create(:event)
    get root_path
    assert_response :success
  end

  test 'should get about' do
    get about_path
    assert_response :success
  end

  test 'should get contact' do
    get contact_path
    assert_response :success
  end

  test 'should get opportunities' do
    get opportunities_path
    assert_response :success
  end

  test 'should get resources' do
    get resources_path
    assert_response :success
  end
end
