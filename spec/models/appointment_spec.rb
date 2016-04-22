require 'rails_helper'

RSpec.describe Appointment, type: :model do
  
  let(:tomorrow_at_ten) { DateTime.now.midnight + 34.hours }
  let(:two_days_later) { DateTime.now.midnight + 59.hours }
  let(:next_week) { DateTime.now.midnight + 14.hours + 7.days }
  let(:in_two_weeks) { DateTime.now.midnight + 16.hours + 14.days }
  let(:four_days_later) { DateTime.now.midnight + 18.hours + 4.days }
  let(:two_days_later_at_two) { DateTime.now.midnight + 14.hours + 2.days }
  let(:tomorrow_at_two) { DateTime.now.midnight + 38.hours }
  let(:tomorrow_at_three) { DateTime.now.midnight + 39.hours }
  
  let(:santa_monica) { Location.find_or_create_by(nickname: "Santa Monica Music", city: "Santa Monica", street_address: "1901 Santa Monica Blvd", state: "CA", zipcode: "90404", business_name: "Santa Monica Music Center") }
  let(:culver_city) { Location.find_or_create_by(nickname: "Culver City Music", city: "Culver City", street_address: "10862 Washington Blvd", state: "CA", zipcode: "90232", business_name: "Culver City Music Center") }
  let(:los_angeles) { Location.find_or_create_by(nickname: "Hurry Curry", city: "Los Angeles", street_address: "12825 Venice Blvd", state: "CA", zipcode: "90066", business_name: "Hurry Curry") }
  let(:starbucks) { Location.find_or_create_by(nickname: "Starbucks") }
  
  let(:sandra) { User.find_by(email: "sandra@sandra.com") || User.create(email: "sandra@sandra.com", password: "sandrapass") }
  let(:dakota) { User.find_by(email: "dakota@dakota.com") || User.create(email: "dakota@dakota.com", password: "dakotapass") }
  
  let(:axel) { Client.find_or_create_by(name: "Axel", phone_number: "(999) 999-9999", email: "axel@gmail.com", user_id: sandra.id) }
  let(:skipper) { Client.find_or_create_by(name: "Skipper", phone_number: "(123) 456-7890", email: "skip@me.com", user_id: sandra.id) }
  let(:ryan) { Client.find_or_create_by(name: "Ryan", phone_number: "(111) 444-7777", email: "ryguy@apple.com", user_id: dakota.id) }
  let(:randy) { Client.find_or_create_by(name: "Randy", phone_number: "(444) 456-8172", email: "randydandy@hotmail.com", user_id: sandra.id) }
  let(:aaron) { Client.find_or_create_by(name: "Aaron", phone_number: "(458) 283-9999", email: "aaronbobaaron@gmail.com", user_id: sandra.id) }
  
  let(:appointment1) { Appointment.find_or_create_by( appointment_time: two_days_later, duration: 3600, price: 80, location_id: santa_monica.id, client_id: axel.id, user_id: sandra.id) }
  let(:appointment2) { Appointment.find_or_create_by( appointment_time: next_week, duration: 5400, price: 110, location_id: culver_city.id, client_id: axel.id, user_id: sandra.id) }
  let(:appointment3) { Appointment.find_or_create_by( appointment_time: in_two_weeks, duration: 5400, price: 110, location_id: culver_city.id, client_id: skipper.id, user_id: sandra.id) }
  let(:appointment4) { Appointment.find_or_create_by( appointment_time: tomorrow_at_ten, duration: 3600, price: 80, location_id: santa_monica.id, client_id: randy.id, user_id: sandra.id) }
  let(:appointment5) { Appointment.find_or_create_by( appointment_time: tomorrow_at_two, duration: 5400, price: 80, location_id: culver_city.id, client_id: aaron.id, user_id: sandra.id) }
  let(:appointment6) { Appointment.find_or_create_by( appointment_time: two_days_later_at_two, duration: 3600, price: 85, location_id: starbucks.id, client_id: ryan.id, user_id: dakota.id) }
  let(:appointment7) { Appointment.find_or_create_by( appointment_time: four_days_later, duration: 3600, price: 75, location_id: los_angeles.id, client_id: skipper.id, user_id: sandra.id) }
  
  let(:valid_attributes) { {appointment_time: two_days_later, duration: 3600, price: 80, location_id: santa_monica.id, client_id: axel.id, user_id: dakota.id } }  
    
  context "attributes" do 
    
    it "has an appointment time" do 
      expect(appointment1.appointment_time).to eq(two_days_later)
    end
    
    it "has a duration" do 
      expect(appointment1.duration).to eq(3600)
    end
    
    it "has a price" do 
      expect(appointment1.price).to eq(80.0)
    end
    
  end 
  
  context "associations" do 
    
    it "belongs to a location" do 
      expect(appointment1.location).to eq(santa_monica)
    end
    
    it "belongs to a client" do 
      expect(appointment1.client).to eq(axel)
    end
    
    it "belongs to a user" do 
      expect(appointment1.user).to eq(sandra)
    end
    
  end 
  
  context "validations" do 
    
    it "must have a duration" do 
      no_duration = Appointment.new( valid_attributes.merge(duration: "") )
      expect(no_duration).not_to be_valid
    end
    
    it "must have an appointment time" do 
      no_time = Appointment.new( valid_attributes.merge(appointment_time: "") )
      expect(no_time).not_to be_valid
    end
    
    it "if it has a price, it must be a positive float" do 
      wrong_price = Appointment.new( valid_attributes.merge(price: -40.0) )
      expect(wrong_price).not_to be_valid
      no_price = Appointment.new( valid_attributes.merge(price: "") )
      expect(no_price).to be_valid
      
    end
    
    it "cannot book an appointment that starts in the middle of another appointment" do 
      Appointment.create(valid_attributes)
      half_an_hour_later = two_days_later + 30.minutes
      conflicting_appointment = Appointment.create( valid_attributes.merge(appointment_time: half_an_hour_later))
      expect(conflicting_appointment).not_to be_valid
    end
    
    it "cannot book an appointment that starts at the same time as another appointment" do 
      Appointment.create(valid_attributes)
      conflicting_appointment = Appointment.create(valid_attributes)
      expect(conflicting_appointment).not_to be_valid
    end
    
  end
  
  
end
