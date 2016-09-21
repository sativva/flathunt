class AddUsernameToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :username, :string
  end
end
