class AddStatusToAnnounces < ActiveRecord::Migration[5.0]
  def change
    add_column :announces, :status, :string
  end
end
