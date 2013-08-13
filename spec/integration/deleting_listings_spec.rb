require 'spec_helper'

 feature "Deleting listing" do
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
    click_link "Delete Listing"
  end

  scenario "Deleting a listing" do
    page.should have_content("Listing has been deleted.")

    visit '/'
    page.should_not have_content("Example listing")
  end
end
