class CreateShipments < ActiveRecord::Migration[5.0]
  def change
    create_table :shipments do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :state
      t.string :postal_code
      t.float :length
      t.float :width
      t.float :height
      t.float :weight
      t.boolean :cylinder

      t.timestamps
    end
  end
end
