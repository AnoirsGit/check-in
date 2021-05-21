class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend

  protect_from_forgery with: :exception

  # after_action :verify_authorized, unless: :devise_controller?

  def after_sign_up_path_for(resource)
    resource.set_code
   end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end
end
