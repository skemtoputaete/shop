class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, :unless => :devise_controller?

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected

  def store_current_location
    store_location_for(:user, request.url)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:username, :email, :password, :password_confirmation, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys:[:username, :email, :password, :password_confirmation, :current_password, :avatar])
  end
  
end
