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
    if params.has_key?(:demo)
      @demo = Demo.new(demo_params)
      if @demo.save
        flash[:notice] = "Successfully sent..."
        TenderBooksNotifierMailer.demo_admin(@demo).deliver_later
        TenderBooksNotifierMailer.demo_user(@demo).deliver_later
      end
    end     
  end

  def privacy_policy  	
  end

  def terms_of_use  	
  end

  def prequalification
  end

  def requisition
  end

  def vendor
  end

  def diligence
  end

  def company
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :subject, :message)
  end

  def demo_params
    params.require(:demo).permit(:first_name, :last_name, :email, :phone, :company, :role)
  end


end
