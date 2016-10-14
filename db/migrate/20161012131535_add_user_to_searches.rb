class AddUserToSearches < ActiveRecord::Migration[5.0]
  def change
    add_reference :searches, :user, foreign_key: true
  end
end



