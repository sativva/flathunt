class ChangeOptionInAnnounces < ActiveRecord::Migration[5.0]
  def change
    change_column :announces, :option , :text
  end
end
