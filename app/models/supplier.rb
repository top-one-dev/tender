class Supplier < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :requests
  has_and_belongs_to_many :categories
  has_many :messages, dependent: :destroy
  has_many :bids, dependent: :destroy

  def company
  	place_holder = Company.new(name: 'Unknown Company', introduction: 'No introduction...' )
  	if self.user.nil?
  		place_holder
  	else
  		if self.user.companies.exists?
  			self.user.companies.first
  		else
  			place_holder
  		end
  	end  	
  end

  def correct_user
  	place_holder = User.new(name: "No name", job_title: 'Unknown Job' )
  	if self.user.nil?
  		place_holder
  	else
  		self.user
  	end	
  end

end
