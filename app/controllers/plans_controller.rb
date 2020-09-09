class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index, :subscribe, :unsubscribe]
  before_action :initiate_plan, only: [:new, :create]
  before_action :set_all_features, only: [:new, :edit]
  before_action :set_plan, only: [:show,:edit, :update, :destroy]
  before_action :set_plans, only: [:index]
  before_action :initialize_subscription, only: [:subscribe]
  before_action :set_subscription, only: [:unsubscribe]

  def create
    @plan.assign_attributes(plan_params)
    if @plan.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def update
    if @plan.update(plan_params)
      flash[:success] = 'Successfully Updated'
      redirect_to plans_url
    else
      render 'edit'
    end
  end

  def destroy
    if @plan.destroy
      flash[:success] = 'Plan deleted'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to plans_url
  end

  def subscribe
    if @subscription.save
      flash[:success] = 'Subscribed Successfully'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to plans_url
  end

  def unsubscribe
    if @subscription.destroy
      flash[:success] = 'UnSubscribed Successfully'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to plans_url
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, feature_ids: [])
  end

  def subscription_params
    params.permit(:plan_id).merge(user_id: current_user.id)
  end

  def initiate_plan
    @plan = Plan.new
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_plans
    @plans = Plan.includes(:features).paginate(page: params[:page], per_page: 10)
  end

  def set_all_features
    @all_features = Feature.all.collect { |x| [x.name, x.id] }
  end

  def initialize_subscription
    @subscription = Subscription.new(subscription_params)
  end

  def set_subscription
    @subscription = Subscription.find_by(subscription_params)
  end
end
