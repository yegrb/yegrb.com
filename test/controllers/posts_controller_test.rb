require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { additional_information: @post.additional_information, content: @post.content, location: @post.location, meetup_description: @post.meetup_description, signup_link: @post.signup_link, thank_you: @post.thank_you, time: @post.time, title: @post.title, user_id: @user.id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { additional_information: @post.additional_information, content: @post.content, location: @post.location, meetup_description: @post.meetup_description, signup_link: @post.signup_link, thank_you: @post.thank_you, time: @post.time, title: @post.title, user_id: @user.id } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
