class AddEmailToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :email, :string
  end
end

