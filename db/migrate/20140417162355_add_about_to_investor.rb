class AddAboutToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :about, :text
  end
end
