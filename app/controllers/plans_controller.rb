class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :initiate_plan, only: [:new, :create]
  before_action :set_all_features, only: [:new, :edit]
  before_action :set_plan, only: [:edit, :update, :destroy]
  before_action :set_plans, only: [:index]
  before_action :set_plan_params, only: [:create, :update]

  def create
    if @plan.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def update
    if @plan.save
      flash[:success] = 'Successfully Updated'
      redirect_to plans_url
    else
      render 'edit'
    end
  end

  def destroy
    @plan.destroy
    flash[:success] = 'Plan deleted'
    redirect_to plans_url
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, feature_ids: [])
  end

  def initiate_plan
    @plan = Plan.new
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_plans
    @plans = Plan.preload(:features).paginate(page: params[:page], per_page: 10)
  end

  def set_plan_params
    @plan.attributes = plan_params
  end

  def set_all_features
    @all_features = Feature.all.collect { |x| [x.name, x.id] }
  end

end
