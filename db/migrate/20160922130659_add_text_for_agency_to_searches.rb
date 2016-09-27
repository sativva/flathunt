class AddTextForAgencyToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :text_for_agency, :text
  end
end
