class TenderBooksNotifierMailer < ApplicationMailer

	default :from => 'tenderbooks@support.com'

	# Bids....

	def bid_supplier(buyer, supplier, request)
		@buyer 		= buyer
		@supplier 	= supplier
		@request 	= request
		mail( :to => @supplier.email,	:subject => 'Thanks for your bidding.' )
	end

	def bid_buyer( buyer, supplier, request)
		@buyer 		= buyer
		@supplier 	= supplier
		@request 	= request
		mail( :to => @buyer.email,	:subject => "#{@supplier.email} made a bid for you" )
	end

	# Rquests....

	def create_request_company(request)
		@request 		= request
		@requisition 	= @request.requisition
		mail(:to => @request.company.email, :subject => "Request ##{@request.id} for requisition ##{@requisition.id} for #{@requisition.name} was created.")
	end

	def create_request_requisitioner(request)
		@request 		= request
		@requisition 	= @request.requisition
		mail(:to => @requisition.contact_email, :subject => "Request ##{@request.id} for requisition ##{@requisition.id} for #{@requisition.name} was created.")
	end

	def invite_supplier(supplier, request)
		@supplier 		= supplier
		@supplier_token = crypt.encrypt_and_sign @supplier.id
		@request 		= request
		mail( :to => @supplier.email,	:subject => 'You are invited!' )
	end

	def invite_notifier(buyer, supplier, request)
		@buyer 		= buyer
		@supplier 	= supplier
		@request 	= request
		mail( :to => @buyer.email,	:subject => 'You sent invite!' )
	end

	def update_supplier(supplier, request, extend)
		@supplier 		= supplier
		@supplier_token = crypt.encrypt_and_sign @supplier.id
		@request 		= request
		@extend 		= extend
		if @extend.nil?
			@subject = "#{@request.name} was updated by buyer at #{@request.updated_at}"
		else
			@subject = "Closing time of the request #{@request.name} was extended by buyer at #{@request.updated_at}"
		end
		mail( :to => @supplier.email,	:subject => @subject )
	end

	def assign_request_buyer(buyer, request)
		@buyer 			= buyer
		@request 		= request
		mail( :to => @buyer.email,	:subject => "#{@request.company.name} assigned the request for #{@request.name} to you." )		
	end

	def assign_request_supplier(buyer, supplier, request)
		@buyer 			= buyer
		@request 		= request
		@supplier 		= supplier
		mail( :to => @supplier.email,	:subject => "#{@request.company.name} assigned the request for #{@request.name} to #{@buyer.name}." )		
	end

	def close_request_buyer(buyer, request)
		@buyer 			= buyer
		@request 		= request
		mail( :to => @buyer.email,	:subject => "#{@request.company.name} closed the request for #{@request.name}." )
	end

	def close_request_supplier(buyer, supplier, request)
		@buyer 			= buyer
		@request 		= request
		@supplier 		= supplier
		mail( :to => @supplier.email,	:subject => "#{@request.company.name} closed the request for #{@request.name}." )				
	end

	# Requisitions....

	def create_requisition_company(requisition, company)
		@requisition 	= requisition
		@company 		= company 
		mail( :to => @company.email,	:subject => "Requisition ##{@requisition.id} for #{@requisition.name} from #{@requisition.contact_name}" )
	end

	def create_requisition_requisitioner(requisition)
		@requisition 	= requisition
		@token 			= crypt.encrypt_and_sign @requisition.contact_email		
		mail( :to => @requisition.contact_email,	:subject => "Yor requisition ##{@requisition.id} for #{@requisition.name} has been received" )
	end

	def create_requisition_colleague(requisition, colleague)
		@requisition 	= requisition
		@colleague 		= colleague
		@token 			= crypt.encrypt_and_sign @colleague.email		
		mail( :to => @colleague.email,	:subject => "You were added to requisition ##{@requisition.id} for #{@requisition.name} by #{@requisition.contact_name}" )			
	end

	def remove_colleague(requisition, colleague)
		@requisition 	= requisition
		@colleague 		= colleague
		mail( :to => @colleague[:email],	:subject => "You were removed from requisition ##{@requisition.id} for #{@requisition.name} by #{@requisition.contact_name}" )
	end

	def assign_requisition_employee(requisition, user)
		@requisition = requisition
		@user 	 	 = user
		mail(to: @user.email, subject: "#{@requisition.company.name} assigned the requisition for #{@requisition.name} to you!")
	end

	def assign_requisition_requisitioner(requisition, user)
		@requisition 	= requisition
		@user 			= user
		mail(:to => @requisition.contact_email, :subject =>"#{@requisition.company.name} assigned the requisition for #{@requisition.name} to #{@user.name}" )		
	end

	def assign_requisition_stockholder(requisition, user, stockholder)
		@requisition 	= requisition
		@user 			= user
		@stockholder 	= stockholder
		mail(:to => @stockholder.email, :subject =>"#{@requisition.company.name} assigned the requisition for #{@requisition.name} to #{@user.name}" )
	end

	def company_invite_colleague(user, company, is_new_user)
		@user 			= user
		@company 		= company
		@is_new_user 	= is_new_user
		mail(:to => @user.email, :subject => "#{@company.owner.name} invites you to join company '#{@company.name}'")
	end

	def set_winner_supplier(request, supplier, subject, content)
		@request  = request
		@supplier = supplier
		@content  = content
		@subject  = subject
		mail(:to => @supplier.email, :subject => @subject )
	end


	# Contact

	def contact_admin(contact)
		@contact = contact
		mail(:to => 'team@tenderbooks.com', :subject => @contact.subject )
	end

	def contact_user(contact)
		@contact = contact
		mail(:to => @contact.email, :subject => 'Thanks for your contacting...' )
	end

	# Request a Demo

	def demo_admin(demo)
		@demo = demo
		mail(:to => 'team@tenderbooks.com', :subject => "Request a demo from #{@demo.email}")
	end

	def demo_user(demo)
		@demo = demo
		mail(to: @demo.email, subject: "You requested a demo")
	end

	private
	
	def crypt
		len   = ActiveSupport::MessageEncryptor.key_len
		key   = ActiveSupport::KeyGenerator.new('tenderbooks').generate_key('coolplum', len)
		ActiveSupport::MessageEncryptor.new(key)
	end

end
