class FeaturesController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user, except: [:index]

  def index
    @features = Feature.paginate(page: params[:page], per_page: 10)
  end

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(feature_params)
    if @feature.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to features_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update_attributes(feature_params)
      flash[:success] = 'Successfully Updated'
      redirect_to features_url
    else
      render 'edit'
    end
  end

  def destroy
    Feature.find(params[:id]).destroy
    flash[:success] = 'Feature deleted'
    redirect_to features_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit)
  end
end
