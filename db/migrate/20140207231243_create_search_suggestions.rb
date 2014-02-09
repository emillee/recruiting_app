class CreateSearchSuggestions < ActiveRecord::Migration
  def change
    create_table :search_suggestions do |t|
      t.string :term
      t.string :popularity

      t.timestamps
    end
    add_index :search_suggestions, :popularity
  end
end
