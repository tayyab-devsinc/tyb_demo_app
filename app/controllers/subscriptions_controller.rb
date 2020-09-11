class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:destroy]

  def index
    @subscriptions = if current_user.admin?
                       Subscription.includes(:plan).paginate(page: params[:page], per_page: 10)
                     else
                       current_user.subscriptions.includes(:plan).paginate(page: params[:page], per_page: 10)
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


  def charge
    subscription = Subscription.find(params[:subscription_id])
    if subscription.save
      t = Transaction.new
      t.subscription_id = subscription.id
      t.user_id = subscription.user_id
      t.amount = Usage.calculate_fee(subscription)
      if t.save
        flash[:success] = 'Subscribed Successfully'
        redirect_to subscriptions_url
      else
        flash[:danger] = 'Error occurred, Try Again'
        render subscriptions_url
      end
    else
      flash[:danger] = 'Error occurred, Try Again'
      render subscriptions_url
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id])
  end
end
