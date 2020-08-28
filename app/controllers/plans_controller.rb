class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :initiate_plan, only: [:new, :create]
  before_action :set_all_features, only: [:new, :create]
  before_action :set_plan, only: [:edit, :update, :destroy]
  before_action :set_plans, only: [:index]

  def create
    # print("\n\n IN CREATE : #{plan_params} \n\n")
    @plan.attributes = plan_params
    if @plan.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
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
    @plan.destroy
    flash[:success] = 'Plan deleted'
    redirect_to plans_url
  end

  private

  def plan_params
    print("\nFROM FORM : #{params}\n\n")
    params.require(:plan).permit(:name, :monthly_fee, features: [])
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

  def set_all_features
    @all_features = Feature.all.collect { |x| [x.name, x.id] }
  end

end
