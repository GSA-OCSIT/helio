class Alert < ActiveRecord::Base
  belongs_to :alert_type
  has_one :agency, :through => :alert_type

  def delivered?
  	!sent_at.nil?
  end
end
