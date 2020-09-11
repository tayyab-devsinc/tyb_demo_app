class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:destroy, :charge]

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
    Transaction.make_transaction(@subscription)
  end

  private

  def set_subscription
    @subscription = Subscription.find_by_id(params[:id] || params[:subscription_id])
  end
end
