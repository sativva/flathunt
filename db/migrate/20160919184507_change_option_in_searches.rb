class ChangeOptionInSearches < ActiveRecord::Migration[5.0]
  def change
    change_column :searches, :option , :text
  end
end
