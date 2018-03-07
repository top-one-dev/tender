class TenderBooksNotifierMailer < ApplicationMailer

	default :from => 'tenderbooks@support.com'

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

	def update_supplier(supplier, request)
		@supplier 		= supplier
		@supplier_token = crypt.encrypt_and_sign @supplier.id
		@request 		= request
		mail( :to => @supplier.email,	:subject => "#{@request.name} was updated at #{@request.updated_at}" )
	end

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

	private
	
	def crypt
		len   = ActiveSupport::MessageEncryptor.key_len
		key   = ActiveSupport::KeyGenerator.new('tenderbooks').generate_key('coolplum', len)
		ActiveSupport::MessageEncryptor.new(key)
	end

end
