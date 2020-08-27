class FeaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: [:index]
  before_action :initialize_feature, only: [:new, :create]
  before_action :set_feature, only: [:edit,:update]
  before_action :set_features, only: [:index]

  def create
    @feature.attributes = feature_params
    if @feature.save
      flash[:success] = 'Feature Successfully Added'
      redirect_to features_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render 'new'
    end
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

  def initialize_feature
    @feature = Feature.new
  end

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def set_features
    @features = Feature.paginate(page: params[:page], per_page: 10)
  end

end
