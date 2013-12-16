class SubscriptionsController < ApplicationController
	before_filter :authenticate_user!

  def index
  	@subscriptions = current_user.subscriptions
  end

  def edit

  end

  def new
  	@alert_types = AlertType.all.collect {|at| at unless Subscription.where(:user=> current_user, :alert_type => at).any? }.compact
  	@subscription = Subscription.new(permitted_params || {})
  end

  def create
  	@subscription = Subscription.new(permitted_params[:subscription])
  	@subscription.user = current_user

  	if @subscription.save
  		redirect_to subscriptions_path, :notice => "You have been subscribed to #{@subscription.alert_type.name}."
  	else
  		render :action => :new
  	end
  end

  def permitted_params
  	params.permit(:subscription => [:alert_type_id])
  end
end
