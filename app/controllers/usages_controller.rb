class UsagesController < ApplicationController
  before_action :set_usages, only: [:index]
  before_action :set_usage, only: [:edit, :update]
  before_action :initialize_usage, only: [:new, :create, :select_usage]
  before_action :set_subscriptions, only: [:add, :show]
  before_action :set_subscription, only: [:new, :edit]
  before_action :subscriptions_features, only: [:new, :edit]

  def create
    @usage.assign_attributes(usage_params)
    if @usage.save
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  def update
    if @usage.update(usage_params)
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  private

  def usage_params
    params.require(:usage).permit(:feature_id, :feature_count, :subscription_id)
  end

  def initialize_usage
    @usage = Usage.new
  end

  def set_usage
    @usage = Usage.includes(:subscription, :feature).find_by_id(params[:id])
  end

  def set_usages
    @usages = Usage.includes(:subscription, :feature).paginate(page: params[:page], per_page: 10)
  end

  def set_subscription
    @subscription = @usage.subscription || Subscription.find_by_id(params[:id] || params[:subscription_id])
  end

  def set_subscriptions
    @subscriptions = Subscription.includes(plan: :features).paginate(page: params[:page], per_page: 10)
  end

  def subscriptions_features
    @subscription_features = if @subscription.nil?
                               @usage.subscription.plan.features.map { |x| [x.name, x.id] }
                             else
                               @subscription.plan.features.map { |x| [x.name, x.id] }
                             end
  end
end
