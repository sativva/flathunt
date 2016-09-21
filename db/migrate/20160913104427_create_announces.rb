class CreateAnnounces < ActiveRecord::Migration[5.0]
  def change
    create_table :announces do |t|
      t.integer :price
      t.string :address
      t.string :floor
      t.integer :charge_by_month
      t.integer :lot
      t.string :agency
      t.string :date_of_publication
      t.boolean :lift
      t.integer :surface
      t.string :room
      t.string :bedroom
      t.boolean :to_renovate
      t.text :comment
      t.boolean :guard
      t.json :option

      t.timestamps
    end
  end
end
