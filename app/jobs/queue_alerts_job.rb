class QueueAlertsJob
	@queue = :queue_alerts

	def self.perform(alert_id)
  	@alert = Alert.find(alert_id)
  	@alert.subscribers.each do |user|
	  	Resque.enqueue(SendAlertJob, alert_id, user.id)
	  end
	  @alert.sent_at = Time.now
	  @alert.save
	end
end