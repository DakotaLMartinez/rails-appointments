class Location < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :clients, through: :appointments
  
  def client_count 
    clients.count
  end
  
  def appointment_count 
    appointments.count
  end
  
  def value
    appointments.collect { |a| a.price }.compact.inject(0, :+)
  end
  
  validates :nickname, presence: true
end
