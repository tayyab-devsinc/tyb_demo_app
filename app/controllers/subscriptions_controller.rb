class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :normal_user

  def subscribe
    subscription = Subscription.new
    subscription.plan_id = params[:subscription_id]
    subscription.user_id = current_user.id
    subscription.subscription_date = Date.today
    subscription.billing_day = Date.today.day > 28 ? 28 : Date.today.day
    if subscription.save
      flash[:success] = 'Subscribed Successfully'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render plans_url
    end
  end

  def unsubscribe
    subscription = Subscription.find_by(user_id: current_user.id, plan_id: params[:subscription_id])
    if subscription.destroy
      flash[:success] = 'UnSubscribed Successfully'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render plans_url
    end
  end

  def normal_user
    redirect_to(root_url) if current_user.admin?
  end
end
