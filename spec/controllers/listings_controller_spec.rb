require 'spec_helper'
describe ListingsController do

  let(:listing) {mock_model(Listing, :id => 1)}
  let!(:category) {Factory(:category)}


  context "non-signed in users" do

   { :new => :get,
     :create => :post,
     :edit => :get,
     :update => :put,
     :destroy => :delete}.each do |action, method|
        it "cannot access the #{action} action" do
        send(method, action, :category_id => category.id, :id => listing.id)
        response.should redirect_to(:new_user_session)
        flash[:alert].should eql("You need to sign in or sign up before continuing.")
      end
    end
  end
end
