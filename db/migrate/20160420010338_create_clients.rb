class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
