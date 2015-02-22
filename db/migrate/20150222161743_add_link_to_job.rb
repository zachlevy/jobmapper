class AddLinkToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :link, :string
  end
end
