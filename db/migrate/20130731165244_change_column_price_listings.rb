class ChangeColumnPriceListings < ActiveRecord::Migration
  def change
    change_column :listings, :price, :decimal, :precision => 16, :scale => 2
  end
end
