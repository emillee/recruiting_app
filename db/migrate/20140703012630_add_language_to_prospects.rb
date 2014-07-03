class AddLanguageToProspects < ActiveRecord::Migration
  def change
  	add_column :prospects, :language, :string
  end
end
