class HomeController < ApplicationController
  def index
  	if current_user
  		redirect_to subscriptions_path
  	else
	  	@subscriptions = Subscription.all
	  	@alerts = Alert.all
	  	@sent_alerts = @alerts.size + @alerts.each {|a| a.subscribers.size}.size
	  end
  end
end
