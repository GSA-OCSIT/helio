class QueueAlertsJob
	@queue = :queue_alerts

	def self.perform(alert_id)
  	@alert = Alert.find(alert_id)
  	@alert.alert_type.subscriptions.each do |subscription|
	  	Resque.enqueue(SendAlertJob, alert_id, subscription.user.id)
	  end
	  @alert.sent_at = Time.now
	  @alert.save
	end
end