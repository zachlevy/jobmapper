class AddEmployerToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :employer, :string
  end
end
