class AddLogoToInvestors < ActiveRecord::Migration
  def change
    add_attachment :investors, :logo
  end
end
