class PlansController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user, except: [:index]

  def index
    @plans = Plan.paginate(page: params[:page], per_page: 10)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new
    @plan.name = plan_params[:name]
    monthly_fee = 0.0
    plan_params[:features]&.each do |fid|
      fr = Feature.find(fid)
      monthly_fee += (fr.unit_price * fr.max_unit_limit)
      @plan.features << fr
    end
    @plan.monthly_fee = monthly_fee
    if @plan.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to plans_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.name = plan_params[:name]
    monthly_fee = @plan.monthly_fee
    plan_params[:features]&.each do |fid|
      fr = Feature.find(fid)
      unless @plan.features.include?(fr)
        monthly_fee += (fr.unit_price * fr.max_unit_limit)
        @plan.features << fr unless @plan.features.include?(fr)
      end
    end
    @plan.monthly_fee = monthly_fee
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

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :monthly_fee, features: [])
  end
end
