class Location < ActiveRecord::Base
  has_many :appointments 
  has_many :clients, through: :appointments
end
