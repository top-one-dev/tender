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
		ActiveRecord::Base.connection.execute("select * from companies_users where user_id = #{user.id} and company_id = #{self.id}").first[2].split('.').first
	end
end
