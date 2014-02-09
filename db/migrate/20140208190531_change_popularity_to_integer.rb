class ChangePopularityToInteger < ActiveRecord::Migration
  def change
    remove_column :search_suggestions, :popularity
    add_column :search_suggestions, :popularity, :integer
  end
end
