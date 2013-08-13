require 'spec_helper'

feature "hidden links" do
  let(:user) { Factory(:confirmed_user) }
  let(:admin) { Factory(:admin_user) }
  let(:category) { Factory(:category) }

  context "anonymous users" do
    scenario "cannot see the New Category link" do
      visit '/'
      assert_no_link_for "New Category"
    end

    scenario "cannot see the Edit Category link" do
      visit category_path(category)
      assert_no_link_for "Edit Category"
    end

    scenario "cannot see the Delete Category link" do
      visit category_path(category)
      assert_no_link_for "Delete Category"
    end
  end


  context "regular users" do
    before { sign_in_as!(user) }
    scenario "cannot see the New Category link" do
      visit '/'
      assert_no_link_for "New Category"
    end

    scenario "cannot see the Edit Category link" do
      visit category_path(category)
      assert_no_link_for "Edit Category"
    end

    scenario "cannot see the Delete Category link" do
      visit category_path(category)
      assert_no_link_for "Delete Category"
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Category link" do
      visit '/'
      assert_link_for "New Category"
    end

    scenario "can see the Edit Category link" do
      visit category_path(category)
      assert_link_for "Edit Category"
    end

    scenario "can see the Delete Category link" do
      visit category_path(category)
      assert_link_for "Delete Category"
    end
  end
end
