require 'rails_helper'

RSpec.describe User, type: :model do
  let(:sandra) { User.find_by(email: "sandra@sandra.com") || User.create(email: "sandra@sandra.com", password: "sandrapass") }
  let(:dakota) { User.find_by(email: "dakota@dakota.com") || User.create(email: "dakota@dakota.com", password: "dakotapass") }
  
  let(:axel) { Client.find_or_create_by(name: "Axel", phone_number: "(999) 999-9999", email: "axel@gmail.com", user_id: sandra.id) }
  let(:skipper) { Client.find_or_create_by(name: "Skipper", phone_number: "(123) 456-7890", email: "skip@me.com", user_id: sandra.id) }
  let(:ryan) { Client.find_or_create_by(name: "Ryan", phone_number: "(111) 444-7777", email: "ryguy@apple.com", user_id: dakota.id) }
  let(:randy) { Client.find_or_create_by(name: "Randy", phone_number: "(444) 456-8172", email: "randydandy@hotmail.com", user_id: sandra.id) }
  let(:aaron) { Client.find_or_create_by(name: "Aaron", phone_number: "(458) 283-9999", email: "aaronbobaaron@gmail.com", user_id: sandra.id) }
  
  let(:santa_monica) { Location.find_or_create_by(nickname: "Santa Monica Music", city: "Santa Monica", street_address: "1901 Santa Monica Blvd", state: "CA", zipcode: "90404", business_name: "Santa Monica Music Center", user_id: sandra.id) }
  let(:culver_city) { Location.find_or_create_by(nickname: "Culver City Music", city: "Culver City", street_address: "10862 Washington Blvd", state: "CA", zipcode: "90232", business_name: "Culver City Music Center", user_id: sandra.id) }
  let(:los_angeles) { Location.find_or_create_by(nickname: "Hurry Curry", city: "Los Angeles", street_address: "12825 Venice Blvd", state: "CA", zipcode: "90066", business_name: "Hurry Curry", user_id: sandra.id) }
  let(:starbucks) { Location.find_or_create_by(nickname: "Starbucks") }
  
  let(:tomorrow_at_ten) { DateTime.now.midnight + 34.hours }
  let(:two_days_later) { DateTime.now.midnight + 59.hours }
  let(:next_week) { DateTime.now.midnight + 14.hours + 7.days }
  let(:in_two_weeks) { DateTime.now.midnight + 16.hours + 14.days }
  let(:four_days_later) { DateTime.now.midnight + 18.hours + 4.days }
  let(:two_days_later_at_two) { DateTime.now.midnight + 14.hours + 2.days }
  let(:tomorrow_at_two) { DateTime.now.midnight + 38.hours }
  let(:tomorrow_at_three) { DateTime.now.midnight + 39.hours }
  
  let(:appointment1) { Appointment.create( appointment_time: two_days_later, duration: 3600, price: 80, location_id: santa_monica.id, client_id: axel.id, user_id: sandra.id) }
  let(:appointment2) { Appointment.create( appointment_time: next_week, duration: 5400, price: 110, location_id: culver_city.id, client_id: axel.id, user_id: sandra.id) }
  let(:appointment3) { Appointment.create( appointment_time: in_two_weeks, duration: 5400, price: 110, location_id: culver_city.id, client_id: skipper.id, user_id: sandra.id) }
  let(:appointment4) { Appointment.create( appointment_time: tomorrow_at_ten, duration: 3600, price: 80, location_id: santa_monica.id, client_id: randy.id, user_id: sandra.id) }
  let(:appointment5) { Appointment.create( appointment_time: tomorrow_at_two, duration: 5400, price: 80, location_id: culver_city.id, client_id: aaron.id, user_id: sandra.id) }
  let(:appointment6) { Appointment.create( appointment_time: two_days_later_at_two, duration: 3600, price: 85, location_id: starbucks.id, client_id: ryan.id, user_id: dakota.id) }
  let(:appointment7) { Appointment.create( appointment_time: four_days_later, duration: 3600, price: 75, location_id: los_angeles.id, client_id: skipper.id, user_id: sandra.id) }

  it "has an email" do
    expect(sandra.email).to eq("sandra@sandra.com")
  end
  
  context "associations" do 
    
    it "has many clients" do 
      # association won't register properly unless the user object is saved first
      [axel, skipper, randy, aaron]
      sandra.save
      expect(sandra.clients).to include(axel, skipper, randy, aaron)
    end
    
    it "has many appointments" do 
      # association won't register properly unless the user object is saved first
      sandra.save
      expect(sandra.appointments).to include(appointment1, appointment2, appointment3, appointment4, appointment5, appointment7)
    end
    
    it "has many locations" do 
      # association won't register properly unless the user object is saved first
      sandra.save
      [santa_monica, culver_city, los_angeles]
      expect(sandra.locations).to include(santa_monica, culver_city, los_angeles)
    end
    
  end
  
end
