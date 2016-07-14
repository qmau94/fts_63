class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def after_sign_in_path_for user
    current_user.is_admin? ? admin_root_path : root_path
  end

  def verify_admin
    unless current_user.is_admin
      flash[:danger] = t "flash.is_not_admin"
      redirect_to root_url
    end
  end
end
