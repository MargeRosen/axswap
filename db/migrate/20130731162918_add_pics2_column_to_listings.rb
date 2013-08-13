class AddPics2ColumnToListings < ActiveRecord::Migration
  def change
    add_column :listings, :pics2, :text
    add_column :listings, :pics3, :text
  end
end
