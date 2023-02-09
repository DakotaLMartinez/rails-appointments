class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
     
  has_many :clients  
  has_many :appointments 
  has_many :locations
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  def upcoming_appointments
    appointments.order(appointment_time: :desc).select { |a| a.appointment_time > (DateTime.now) }
  end
  
end
