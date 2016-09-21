class CreateAgencies < ActiveRecord::Migration[5.0]
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :mail
      t.string :address
      t.integer :postal
      t.string :phone
      t.string :url
      t.string :logo

      t.timestamps
    end
  end
end
