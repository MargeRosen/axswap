class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :location
      t.decimal :price
      t.string :contact
      t.text :pics
      t.references :category

      t.timestamps
    end
    add_index :listings, :category_id
  end
end
