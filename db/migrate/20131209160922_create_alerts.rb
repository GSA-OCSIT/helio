class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :alert_type, index: true
      t.text :body
      t.time :sent_at

      t.timestamps
    end
  end
end
