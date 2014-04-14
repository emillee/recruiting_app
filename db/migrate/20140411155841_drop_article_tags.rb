class DropArticleTags < ActiveRecord::Migration
  def change
    drop_table :article_tags
  end
end
