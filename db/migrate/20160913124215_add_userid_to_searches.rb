class AddUseridToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :userid, :integer
  end
end
