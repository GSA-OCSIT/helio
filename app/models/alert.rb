class Alert < ActiveRecord::Base
  belongs_to :alert_type
  has_one :agency, :through => :alert_type
  after_create :queue_alerts

  def delivered?
  	!sent_at.nil?
  end

  def queue_alerts
  	Resque.enqueue(QueueAlertsJob, self.id)
  end
end
