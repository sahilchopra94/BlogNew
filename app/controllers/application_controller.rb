class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
      before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token, if: :json_request?

  def after_sign_in_path_for(resources)
  	articles_path
  	
  end
  def store_current_location
  	store_current_location_for(:user,request.url)
end
protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password, :image])
  end
  def json_request?
    request.format.json?
  end
end
