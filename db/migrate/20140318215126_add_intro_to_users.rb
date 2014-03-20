class AddIntroToUsers < ActiveRecord::Migration
  def change
    add_column :users, :intro, :string
  end
end
