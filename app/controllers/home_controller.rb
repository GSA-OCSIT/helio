class HomeController < ApplicationController
  def index
  	if current_user
  		redirect_to subscriptions_path
  	else
	  	@subscriptions = Subscription.all
	  end
  end
end
