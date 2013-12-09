class Agency < ActiveRecord::Base
	has_many :users
	has_many :alert_types
	has_many :alerts, :through => :alert_types
	has_many :subscriptions, :through => :alert_types
end
