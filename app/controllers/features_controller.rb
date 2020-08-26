class FeaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :create_feature_instance, only: [:new]
  before_action :feature_instance, only: [:edit,:update]

  def index
    @features = Feature.paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def create
    feature = Feature.new(feature_params)
    if feature.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to features_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @feature.update(feature_params)
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

  private

  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit)
  end

  def create_feature_instance
    @feature = Feature.new
  end

  def feature_instance
    @feature = Feature.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
