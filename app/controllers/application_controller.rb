class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :initialize_search
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def initialize_search
    @search = Search.new
  end

  def after_sign_in_path_for(resource)
  #   request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  # # redirect to the form if there is a form_data in the session
  #   if session[:form_data].present?
    if current_user.searches.empty?
      new_user_search_path(current_user)
    else
      super
    end
  #   else
  #     #if there is not temp list in the session proceed as normal
  #     super
  #   end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation) }
  end
end

