class StaticController < ApplicationController
  
  def home
  	if user_signed_in?
  		redirect_to dashboard_request_url
  	end
  end

  def privacy_policy
  	
  end

  def terms_of_use
  	
  end


end
