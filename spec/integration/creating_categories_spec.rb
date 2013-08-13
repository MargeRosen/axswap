require 'spec_helper'

feature 'Creating Categories' do
  before do
    visit '/'
    sign_in_as!(Factory(:admin_user))
    visit '/'
    click_link 'New Category'
  end

  scenario "can create a category" do
    fill_in 'Name', :with => 'Keyboards'
    click_button 'Create Category'
    page.should have_content('Category has been created.')

    category = Category.find_by_name('Keyboards')
    page.current_url.should == category_url(category)
    title = "Keyboards - Categories - AxSwap"
    find("title").should have_content(title)
    click_link 'Back to Categories Page'
    page.current_path.should == categories_path
  end

  scenario "cannot create a category without a name" do
    click_button 'Create Category'
    page.should have_content("Category has not been created.")
    page.should have_content("Name can't be blank")
  end
end
