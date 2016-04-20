class Location < ActiveRecord::Base
  has_many :appointments 
  has_many :clients, through: :appointments
  
  validates :nickname, presence: true
end
