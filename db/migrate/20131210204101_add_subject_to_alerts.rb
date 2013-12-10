class AddSubjectToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :subject, :string
  end
end
