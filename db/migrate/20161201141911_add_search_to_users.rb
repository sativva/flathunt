class AddSearchToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :search, foreign_key: true
  end
end
