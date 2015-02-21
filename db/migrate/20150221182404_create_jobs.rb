class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :title

      t.timestamps
    end
  end
end
