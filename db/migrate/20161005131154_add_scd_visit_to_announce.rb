class AddScdVisitToAnnounce < ActiveRecord::Migration[5.0]
  def change
    add_column :announces, :scd_visit, :boolean
  end
end
