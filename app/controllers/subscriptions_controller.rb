class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :normal_user, only: [:subscribe, :unsubscribe]

  def index
    @subscriptions = if current_user.admin?
                       Subscription.paginate(page: params[:page], per_page: 10)
                     else
                       Subscription.where(:user_id => current_user.id).paginate(page: params[:page], per_page: 10)
                     end

  end

  def destroy
    Subscription.find(params[:id]).destroy
    flash[:success] = 'Subscription Canceled'
    redirect_to subscriptions_url
  end

  def update
    @subscription = Subscription.find(params[:id])
    @subscription.active = !@subscription.active
    if @subscription.save
      flash[:success] = 'Successfully Updated'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  def subscribe
    ActiveRecord::Base.transaction do
      subscription = Subscription.new
      subscription.plan_id = params[:subscription_id]
      subscription.user_id = current_user.id
      subscription.subscription_date = Date.today
      subscription.billing_day = Date.today.day > 28 ? 28 : Date.today.day
      if subscription.save
        t = Transaction.new
        t.subscription_id = subscription.id
        t.user_id = subscription.user_id
        t.amount = subscription.plan.monthly_fee
        if t.save
          flash[:success] = 'Subscribed Successfully'
          redirect_to plans_url
        else
          flash[:danger] = 'Error occurred, Try Again'
          render plans_url
        end
      else
        flash[:danger] = 'Error occurred, Try Again'
        render plans_url
      end
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
