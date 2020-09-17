class UsagesController < ApplicationController
  before_action :set_usage, only: [:edit, :update]
  before_action :initialize_usage, only: [:new, :create]
  before_action :set_subscription, only: [:new, :edit, :create, :index]
  before_action :set_subscriptions_features, only: [:new, :edit]

  def create
    if @subscription.usages.create(usage_params)
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  rescue ActiveRecord::RecordNotUnique
    flash[:danger] = 'Usage Already Exist, Try to update'
    redirect_to subscriptions_url
  end

  def update
    if @usage.update(usage_params)
      flash[:success] = 'Usage Successfully Updated'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to subscriptions_url
  end

  private

  def usage_params
    params.require(:usage).permit(:feature_id, :feature_count)
  end

  def initialize_usage
    @usage = Usage.new
    authorize @usage
  end

  def set_usage
    @usage = Usage.find_by_id(params[:id])
    authorize @usage
  end

  def set_subscription
    @subscription = Subscription.includes(:usages).find_by_id(params[:subscription_id])
  end

  def set_subscriptions_features
    @subscription_features = @subscription.plan.features.map { |x| [x.name, x.id] }
  end
end
