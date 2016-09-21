class AddSearchToAnnounces < ActiveRecord::Migration[5.0]
  def change
    add_reference :announces, :search, foreign_key: true
  end
end
