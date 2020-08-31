class UsagesController < ApplicationController
  before_action :set_usages, only: [:index]
  before_action :set_usage, only: [:edit, :update]
  before_action :initialize_usage, only: [:new, :create, :select_usage]
  before_action :set_subscriptions, only: [:add]
  before_action :set_subscription, only: [:select_usage, :edit]
  before_action :subscriptions_features, only: [:select_usage, :edit]

  def select_usage
    render 'new'
  end

  def create
    @usage.feature = Feature.find(usage_params[:feature])
    @usage.feature_count = usage_params[:feature_count]
    @usage.subscription = Subscription.find(usage_params[:subscription_id])
    if @usage.save
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  def update
    print("\n\n #{usage_params}\n\n")
    @usage.feature_count = usage_params[:feature_count]
    if @usage.save
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  private

  def usage_params
    params.require(:usage).permit(:feature, :feature_count, :subscription_id)
  end

  def initialize_usage
    @usage = Usage.new
  end

  def set_usage
    @usage = Usage.preload(:subscription, :feature).find(params[:id])
  end

  def set_usages
    @usages = Usage.preload(:subscription, :feature).paginate(page: params[:page], per_page: 10)
  end

  def set_subscription
    @subscription = if params[:usage_id].nil?
                      @usage.subscription
                    else
                      Subscription.find(params[:usage_id])
                    end
  end

  def set_subscriptions
    @subscriptions = Subscription.preload(:plan, plan: :features).paginate(page: params[:page], per_page: 10)
  end

  def subscriptions_features
    @subscription_features = if @subscription.nil?
                               @usage.subscription.plan.features.map { |x| [x.name, x.id] }
                             else
                               @subscription.plan.features.map { |x| [x.name, x.id] }
                             end
  end
end
