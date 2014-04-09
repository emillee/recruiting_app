class CreateInvestors < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.string :name
      t.string :neighborhood
      t.string :stage, array: true, default: []

      t.timestamps
    end
  end
end
