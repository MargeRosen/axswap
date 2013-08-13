require 'spec_helper'

feature "Editing Listing" do
    let!(:category) {Factory(:category)}
    let!(:user) {Factory(:confirmed_user)}
    let!(:listing) do
      listing = Factory(:listing, :title => "Yamaha", category_id: category.id, :description => "Plays great!")
      listing.update_attribute(:user, user)
      listing
    end

  before do
    sign_in_as!(user)
    visit '/'
    click_link category.name
    click_link listing.title
    click_link "Edit Listing"
  end

  scenario "Updating a listing" do
    fill_in "Title", :with => "Example listing"
    click_button "Update Listing"
    page.should have_content("Listing has been updated.")
    within("#listing h4") do
      page.should have_content("Plays great!")
    end

    page.should_not have_content(listing.title)
  end

  scenario "Updating a category with invalid info" do
    fill_in "Title", :with => ""
    click_button "Update Listing"
    page.should have_content("Listing has not been updated.")
  end
end
