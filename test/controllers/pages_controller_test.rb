# typed: false
require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    create(:future_event)
    get root_path
    assert_response :success
  end

  test 'should get about' do
    get aboutus_path
    assert_response :success
  end

  test 'should get get involved' do
    get getinvolved_path
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
