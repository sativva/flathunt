class AddPhotosToAnnounces < ActiveRecord::Migration[5.0]
  def change
    add_column :announces, :photos, :json
  end
end
