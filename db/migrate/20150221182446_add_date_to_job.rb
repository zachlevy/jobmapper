class AddDateToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :posted_at, :datetime
  end
end
