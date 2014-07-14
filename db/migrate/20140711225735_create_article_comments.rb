class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
    	t.integer :article_id
    	t.integer :comment_id

    	t.timestamps
    end
  end
end
