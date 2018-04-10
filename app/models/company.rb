class Company < ApplicationRecord
	validates :name, :country, :email, presence: true
	validates :name, :email, uniqueness: true
	has_many :requests, dependent: :destroy
	has_many :requisitions, dependent: :destroy
	has_and_belongs_to_many :users

	def owner
		User.find self.user
	end
	
	def added_at user
		puts ActiveRecord::Base.connection.execute("select * from companies_users where user_id = #{user.id} and company_id = #{self.id}")
		ActiveRecord::Base.connection.execute("select * from companies_users where user_id = #{user.id} and company_id = #{self.id}").first['created_at'].split('.').first
	end

	def suppliers
		company_suppliers = []
		self.requests.collect {|r| r.suppliers.each {|s| company_suppliers << s } }

		unless company_suppliers.empty?
			company_suppliers.uniq!
		end
		company_suppliers
	end
end
