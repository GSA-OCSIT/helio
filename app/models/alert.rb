class Alert < ActiveRecord::Base
  belongs_to :alert_type, :dependent => :destroy
  has_one :agency, :through => :alert_type
  after_create :queue_alerts

  def delivered?
  	!sent_at.nil?
  end

  def queue_alerts
  	Resque.enqueue(QueueAlertsJob, self.id)
  end

  def name
  	"#{self.alert_type.name} - #{self.subject}"
  end

  def subscribers
    unless self.zip.blank? and !self.is_parent? and self.gender.blank?
      sub = self.alert_type.subscriptions.collect do |sub|
        rtn = true
        if !self.zip.blank?
          sub.user.zip == self.zip ? (rtn = true) : (rtn = false) 
        end
        if self.is_parent? and rtn == true
          sub.user.is_parent? ? (rtn = true) : (rtn = false)
        end
        if !self.gender.blank? and rtn == true
          sub.user.gender == self.gender ? (rtn = true) : (rtn = false) 
        end
        sub.user if rtn
      end
      sub.compact!
    else
      self.alert_type.subscriptions.collect {|sub| sub.user}
    end
  end

  def self.recent(num=5)
  	Alert.order(:created_at).limit(num)
  end
end
