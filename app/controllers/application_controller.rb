class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:username]
  end

  private
  def after_sign_in_path_for user
    current_user.is_admin? ? admin_root_path : root_path
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "flash.is_not_admin"
      redirect_to root_url
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t("flash.recordnotfound", column_name: params[:id])
    redirect_to root_url
  end
end
