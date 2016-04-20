class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :nickname
      t.string :city
      t.string :street_address
      t.string :state
      t.string :zipcode
      t.string :business_name
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
