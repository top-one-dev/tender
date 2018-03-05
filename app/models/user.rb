class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_one :notification, dependent: :destroy
  has_many :requests
  has_many :requisitions # assigned requisitions
  has_many :messages
  has_one :supplier
  has_and_belongs_to_many :companies

  def send_devise_notification(notification, *args)
	devise_mailer.send(notification, self, *args).deliver_later
  end

end
