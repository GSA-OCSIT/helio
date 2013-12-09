class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :zip, :integer
  	add_column :users, :zip_four, :integer
  	add_column :users, :gender, :text
  	add_column :users, :is_parent, :boolean
  end
end
