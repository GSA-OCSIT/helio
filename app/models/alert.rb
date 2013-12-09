class Alert < ActiveRecord::Base
  belongs_to :alert_type
  has_one :agency, :through => :alert_type

end
