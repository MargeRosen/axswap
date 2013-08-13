require 'spec_helper'

feature "Editing Categories" do
  before do
    sign_in_as!(Factory(:admin_user))
    Factory(:category, :name => "Keyboards")
    visit '/'
    click_link "Keyboards"
    click_link "Edit Category"
  end

  scenario "Updating a category" do
    fill_in "Name", :with => "Electric Keyboards"
    click_button "Update Category"
    page.should have_content("Category has been updated.")
  end

  scenario "Updating a category with invalid attributes" do
    fill_in "Name", :with => ""
    click_button "Update Category"
    page.should have_content("Category has not been updated.")
  end
end
