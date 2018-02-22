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

	private
	
	def crypt
		len   = ActiveSupport::MessageEncryptor.key_len
		key   = ActiveSupport::KeyGenerator.new('tenderbooks').generate_key('coolplum', len)
		ActiveSupport::MessageEncryptor.new(key)
	end

end
