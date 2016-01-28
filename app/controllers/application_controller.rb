class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Common

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_currentparams

  def set_currentparams
    @current_date  = current_date
    @current_month = current_month
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:userid, :name, :email, :password, :password_confirmation, :remember_me, :company_id) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:userid, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:userid, :name, :email, :password, :password_confirmation, :current_password, :company_id) }
  end
end
