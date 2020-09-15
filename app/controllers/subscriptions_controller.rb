class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, except: [:index]
  before_action :initialize_usage, only: [:new_usage]
  before_action :set_usage, only: [:edit_usage]

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
    if @subscription.charge_fee
      flash[:success] = 'Fee Charged'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  def create_usage
    if @subscription.usages.create(usage_params)
      flash[:success] = 'Usage Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  private

  def usage_params
    params.require(:usage).permit(:feature_id, :feature_count)
  end

  def set_subscription
    @subscription = Subscription.find_by_id(params[:id] || params[:subscription_id])
  end

  def initialize_usage
    @usage = Usage.new
  end

  def set_usage
    @usage = Usage.first
  end
end
