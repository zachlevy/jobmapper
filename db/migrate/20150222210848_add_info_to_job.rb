class AddInfoToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :info, :string
  end
end
