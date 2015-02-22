class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations, :id => false do |t|
      t.primary_key :gov_id
      t.string :name

      t.timestamps
    end
  end
end
