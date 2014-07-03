class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
    	t.string :github_username
    	t.string :first_name
    	t.string :last_name
    	t.string :city
    	t.string :date_joined
    	t.string :email
    end
  end
end
