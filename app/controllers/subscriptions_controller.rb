class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:update, :destroy]

  def index
    @subscriptions = if current_user.admin?
                       Subscription.paginate(page: params[:page], per_page: 10)
                     else
                       current_user.subscriptions.paginate(page: params[:page], per_page: 10)
                     end
  end

  def destroy
    if @subscription.destroy
      flash[:success] = 'Subscription Canceled'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  def update
    if @subscription.update_attributes(active: !@subscription.active)
      flash[:success] = 'Successfully Updated'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  def subscribe
    subscription = Subscription.new(subscription_params)
    if subscription.save && Transaction.subscription_transaction(subscription)
      flash[:success] = 'Subscribed Successfully'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to plans_url
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

  private

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id])
  end

  def subscription_params
    {plan_id: params[:subscription_id],
     user_id: current_user.id,
     subscription_date: Date.today,
     billing_day: Date.today.day > 28 ? 28 : Date.today.day}
  end
end
