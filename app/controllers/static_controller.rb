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

  def contact
    if params.has_key?(:contact)
      @contact = Contact.new(contact_params)
      if verify_recaptcha(model: @contact) && @contact.save
        flash[:notice] = "Successfully sent..."
        TenderBooksNotifierMailer.contact_admin(@contact).deliver_later
        TenderBooksNotifierMailer.contact_user(@contact).deliver_later
      end
    end    
  end

  def demo
    
  end

  def privacy_policy
  	
  end

  def terms_of_use
  	
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :subject, :message)
  end


end
