class Location < ActiveRecord::Base
  belongs_to :user
  has_many :appointments 
  has_many :clients, through: :appointments
  
  def client_count 
    clients.count
  end
  
  def appointment_count 
    appointments.count
  end
  
  validates :nickname, presence: true
end
