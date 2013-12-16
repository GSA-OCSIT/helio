class AddParentToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :is_parent, :boolean
  end
end
