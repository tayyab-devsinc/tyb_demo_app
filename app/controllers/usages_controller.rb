class UsagesController < ApplicationController
  before_action :set_usages, only: [:index]
  before_action :initialize_usage, only: [:new, :create, :select_usage]
  before_action :set_subscriptions, only: [:add]
  before_action :set_subscription, only: [:select_usage]

  def select_usage
    render 'new'
  end

  def create
    print("\n\n #{usage_params[:feature]}\n\n")
    @usage.feature = Feature.find(usage_params[:feature])
    @usage.feature_count = usage_params[:feature_count]
    @usage.subscription = @subscription
    if @usage.save
      flash[:success] = 'Usage Successfully Added'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to usages_url
  end

  private

  def usage_params
    params.require(:usage).permit(:feature, :feature_count)
  end

  def initialize_usage
    @usage = Usage.new
  end

  def set_usages
    @usages = Usage.preload(:subscription, :feature).paginate(page: params[:page], per_page: 10)
  end

  def set_subscription
    @subscription = Subscription.find(params[:usage_id])
  end

  def set_subscriptions
    @subscriptions = Subscription.preload(:plan, plan: :features).paginate(page: params[:page], per_page: 10)
  end

end
