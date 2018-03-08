class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_one :notification, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :requisitions # assigned requisitions
  has_many :messages, dependent: :destroy
  has_one :supplier, dependent: :destroy
  has_and_belongs_to_many :companies

  def send_devise_notification(notification, *args)
	 devise_mailer.send(notification, self, *args).deliver_later
  end

  def status
    unless self.locked_at
      if self.confirmed_at
        "active"
      else
        "unconfirmed"
      end 
    else
      "locked"
    end
  end

end
