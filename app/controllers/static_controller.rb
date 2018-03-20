class StaticController < ApplicationController
  
  def home
  	if user_signed_in?
  		redirect_to requests_path
  	end
  end

  def landing_page
    if user_signed_in?
      redirect_to requests_path
    end
  end

  def privacy_policy
  	
  end

  def terms_of_use
  	
  end


end
