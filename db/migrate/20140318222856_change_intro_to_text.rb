class ChangeIntroToText < ActiveRecord::Migration
  def change
    change_column :users, :intro, :text
  end
end
