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
		Supplier.all.each do |supplier|
			supplier.requests.each do |request|
				if request.company == self
					company_suppliers << supplier
					unless supplier.user.nil?
						company_suppliers.last[:name] = supplier.user.name
						unless supplier.user.companies.exists?
							company_suppliers.last[:company] = supplier.user.companies.first.name
						end
					end
				end
			end
		end

		unless company_suppliers.empty?
			company_suppliers.uniq!
		end
		company_suppliers
	end
end
