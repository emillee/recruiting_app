class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :content
    	t.integer :user_id
    end
  end
end
