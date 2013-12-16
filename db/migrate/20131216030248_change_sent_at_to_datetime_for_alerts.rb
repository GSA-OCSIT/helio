class ChangeSentAtToDatetimeForAlerts < ActiveRecord::Migration
  def change
  	change_column :alerts, :sent_at, :datetime
  end
end
