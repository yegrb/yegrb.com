require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    fill_in "Additional information", with: @post.additional_information
    fill_in "Content", with: @post.content
    fill_in "Location", with: @post.location
    fill_in "Meetup description", with: @post.meetup_description
    fill_in "Signup link", with: @post.signup_link
    fill_in "Thank you", with: @post.thank_you
    fill_in "Time", with: @post.time
    fill_in "Title", with: @post.title
    fill_in "User", with: @post.user_id
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Additional information", with: @post.additional_information
    fill_in "Content", with: @post.content
    fill_in "Location", with: @post.location
    fill_in "Meetup description", with: @post.meetup_description
    fill_in "Signup link", with: @post.signup_link
    fill_in "Thank you", with: @post.thank_you
    fill_in "Time", with: @post.time
    fill_in "Title", with: @post.title
    fill_in "User", with: @post.user_id
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
