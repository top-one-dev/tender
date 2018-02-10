class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_company
    if Company.exists? session[:current_company_id]
      return Company.find session[:current_company_id]
    else
      session[:current_company_id] = nil
      return nil
    end
  end
  
  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :country ])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :mobile, :job_title, :language, :timezone, :country, :company])
  end

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to new_user_session_path, :notice => 'You need to sign in to continue.'
  #   end
  # end

end
