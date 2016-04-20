class Client < ActiveRecord::Base
  belongs_to :user
  has_many :appointments 
  has_many :locations, through: :appointments
end
