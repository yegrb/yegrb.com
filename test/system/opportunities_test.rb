# typed: false
require 'application_system_test_case'

class OpportunitiesTest < ApplicationSystemTestCase
  setup do
    @opportunity = opportunities(:one)
  end

  test 'visiting the index' do
    visit opportunities_url
    assert_selector 'h1', text: 'Opportunities'
  end

  test 'creating a Opportunity' do
    visit opportunities_url
    click_on 'New Opportunity'

    fill_in 'Company', with: @opportunity.company
    fill_in 'Contact', with: @opportunity.contact
    fill_in 'Content', with: @opportunity.content
    fill_in 'Email', with: @opportunity.email
    fill_in 'Good until', with: @opportunity.good_until
    fill_in 'Paid position', with: @opportunity.paid_position
    fill_in 'Title', with: @opportunity.title
    fill_in 'User', with: @opportunity.user_id
    click_on 'Create Opportunity'

    assert_text 'Opportunity was successfully created'
    click_on 'Back'
  end

  test 'updating a Opportunity' do
    visit opportunities_url
    click_on 'Edit', match: :first

    fill_in 'Company', with: @opportunity.company
    fill_in 'Contact', with: @opportunity.contact
    fill_in 'Content', with: @opportunity.content
    fill_in 'Email', with: @opportunity.email
    fill_in 'Good until', with: @opportunity.good_until
    fill_in 'Paid position', with: @opportunity.paid_position
    fill_in 'Title', with: @opportunity.title
    fill_in 'User', with: @opportunity.user_id
    click_on 'Update Opportunity'

    assert_text 'Opportunity was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Opportunity' do
    visit opportunities_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Opportunity was successfully destroyed'
  end
end
