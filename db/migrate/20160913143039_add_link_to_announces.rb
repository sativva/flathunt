class AddLinkToAnnounces < ActiveRecord::Migration[5.0]
  def change
    add_column :announces, :link, :string
  end
end
