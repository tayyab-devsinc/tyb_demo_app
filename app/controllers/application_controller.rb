class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_photo])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_to(root_url)
  end
end
