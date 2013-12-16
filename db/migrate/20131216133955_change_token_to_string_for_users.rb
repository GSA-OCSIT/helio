class ChangeTokenToStringForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :token, :string
  end
end
