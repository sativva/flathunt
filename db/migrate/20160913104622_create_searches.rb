class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :price
      t.string :location
      t.string :floor
      t.boolean :lift
      t.string :surface
      t.string :room
      t.string :bedroom
      t.string :to_renovate
      t.text :comment
      t.json :option

      t.timestamps
    end
  end
end
