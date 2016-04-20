class Appointment < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  belongs_to :client
end
