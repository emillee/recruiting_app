class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.attachment :image_file
    end
  end
end
