class CreateAlertTypes < ActiveRecord::Migration
  def change
    create_table :alert_types do |t|
      t.string :name
      t.string :slug
      t.references :agency, index: true

      t.timestamps
    end
  end
end
