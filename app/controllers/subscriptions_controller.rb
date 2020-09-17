class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, except: [:index]

  def index
    @subscriptions = policy_scope(Subscription).paginate(page: params[:page], per_page: 10)
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
    if @subscription.charge_fee
      flash[:success] = 'Fee Charged'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  private

  def set_subscription
    @subscription = Subscription.find_by_id(params[:id] || params[:subscription_id])
    authorize @subscription
  end
end
