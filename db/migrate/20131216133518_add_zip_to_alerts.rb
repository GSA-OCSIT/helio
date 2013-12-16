class AddZipToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :zip, :integer
  end
end
