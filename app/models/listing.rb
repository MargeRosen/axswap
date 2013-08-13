class Listing < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :contact, :description, :location, :pics, :pics2, :pics3, :price, :title
  validates :title, :presence => true
  validates :description, :presence => true
end
