class AddDescriptionToAlertTypes < ActiveRecord::Migration
  def change
  	add_column :alert_types, :description, :text
  end
end
