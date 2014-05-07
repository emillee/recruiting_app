class MigrationToCreateMessages < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  		t.string :message_body
  		t.integer :user_id

  		t.timestamps
  	end

  	add_index :messages, :user_id
  end
end
