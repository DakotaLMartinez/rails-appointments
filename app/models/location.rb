class Location < ActiveRecord::Base
  belongs_to :user
  has_many :appointments 
  has_many :clients, through: :appointments
  
  validates :nickname, presence: true
end
