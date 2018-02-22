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

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '104.156.218.100'
    else
      request.remote_ip
    end
  end

  def current_geo
    url = "http://usercountry.com/v1.0/json/#{remote_ip}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return JSON.parse(response)  
  end

  def crypt
    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new('tenderbooks').generate_key('coolplum', len)
    ActiveSupport::MessageEncryptor.new(key)
  end
  
  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :country ])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :mobile, :job_title, :language, :timezone, :country, :company])
  end

end
