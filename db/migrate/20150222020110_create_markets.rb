class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets, :id => false do |t|
      t.primary_key :noc_id
      t.string :name

      t.timestamps
    end
  end
end
