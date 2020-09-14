class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :initiate_plan, only: [:new, :create]
  before_action :set_all_features, only: [:new, :edit]
  before_action :set_plan, only: [:show,:edit, :update, :destroy, :subscribe]
  before_action :set_plans, only: [:index]

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
    if current_user.plans << @plan
      flash[:success] = 'Subscribed Successfully'
    else
      flash[:danger] = 'Error occurred, Try Again'
    end
    redirect_to plans_url
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, feature_ids: [])
  end

  def initiate_plan
    @plan = Plan.new
    authorize @plan
  end

  def set_plan
    @plan = Plan.find_by_id(params[:id] || params[:plan_id])
    authorize @plan
  end

  def set_plans
    @plans = Plan.includes(:features).paginate(page: params[:page], per_page: 10)
  end

  def set_all_features
    @all_features = Feature.all.collect { |x| [x.name, x.id] }
  end
end
