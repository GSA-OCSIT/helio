class AddGenderToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :gender, :string
  end
end
