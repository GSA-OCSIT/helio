class ChangeSentAtToDatetimeForAlerts < ActiveRecord::Migration
  def change
  	# change_column :alerts, :sent_at, :datetime
  	"ALTER TABLE alerts DROP COLUMN sent_at;"
  	"ALTER TABLE alerts ADD COLUMN sent_at timestamp;"
  end
end
