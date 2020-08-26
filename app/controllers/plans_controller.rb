class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :create_plan_instance, only: [:new]
  before_action :plan_instance, only: [:edit, :update]

  def index
    @plans = Plan.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def create
    params = { name: plan_params[:name] }
    plan = Plan.new(params)
    plan.add_features(plan_params[:features])
    if plan.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def edit
  end

  def update
    @plan.name = plan_params[:name]
    @plan.features.clear
    @plan.add_features(plan_params[:features])
    if @plan.save
      flash[:success] = 'Successfully Updated'
      redirect_to plans_url
    else
      render 'edit'
    end
  end

  def destroy
    Plan.find(params[:id]).destroy
    flash[:success] = 'Plan deleted'
    redirect_to plans_url
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, features: [])
  end

  def create_plan_instance
    @plan = Plan.new
  end

  def plan_instance
    @plan = Plan.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
