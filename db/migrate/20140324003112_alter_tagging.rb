class AlterTagging < ActiveRecord::Migration
  def change
    add_column :taggings, :article_id, :integer
  end
end
