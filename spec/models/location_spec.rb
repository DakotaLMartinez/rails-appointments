require 'rails_helper'

RSpec.describe Location, type: :model do
   let!(:santa_monica) { Location.find_or_create_by(nickname: "Santa Monica Music", city: "Santa Monica", street_address: "1901 Santa Monica Blvd", state: "CA", zipcode: "90404", business_name: "Santa Monica Music Center") }
   
   context "attributes" do 
    
    it "has a nickname" do 
      expect(santa_monica.nickname).to eq("Santa Monica Music")
    end
    
    it "has a city" do 
      expect(santa_monica.city).to eq("Santa Monica")
    end
    
    it "has a street address" do 
      expect(santa_monica.street_address).to eq("1901 Santa Monica Blvd")
    end
    
    it "has a state" do 
      expect(santa_monica.state).to eq("CA")
    end
    
    it "has a zipcode" do 
      expect(santa_monica.zipcode).to eq("90404")
    end
    
    it "has a business name" do 
      expect(santa_monica.business_name).to eq("Santa Monica Music Center")
    end
    
  end
  
  context "associations" do 
    
    let(:tomorrow_at_ten) { DateTime.now.midnight + 34.hours }
    let(:two_days_later) { DateTime.now.midnight + 59.hours }
    
    let(:sandra) { User.find_by(email: "sandra@sandra.com") || User.create(email: "sandra@sandra.com", password: "sandrapass") }
    
    let(:axel) { Client.find_or_create_by(name: "Axel", phone_number: "(999) 999-9999", email: "axel@gmail.com", user_id: sandra.id) }
    let(:randy) { Client.find_or_create_by(name: "Randy", phone_number: "(444) 456-8172", email: "randydandy@hotmail.com", user_id: sandra.id) }
    
    let(:appointment1) { Appointment.find_or_create_by( appointment_time: two_days_later, duration: 3600, price: 80, location_id: santa_monica.id, client_id: axel.id, user_id: sandra.id) }
    let(:appointment4) { Appointment.find_or_create_by( appointment_time: tomorrow_at_ten, duration: 3600, price: 80, location_id: santa_monica.id, client_id: randy.id, user_id: sandra.id) }
    
    it "has many appointments" do
      [appointment1, appointment4]
      expect(santa_monica.appointments).to include(appointment1, appointment4)
    end
    
    it "has many clients through appointments" do 
      [appointment1, appointment4]
      expect(santa_monica.clients).to include(axel, randy)
    end
    
  end
  
  context "validations" do 
  
    let(:valid_attributes) { { nickname: "Santa Monica Music", city: "Santa Monica", street_address: "1901 Santa Monica Blvd", state: "CA", zipcode: "90404", business_name: "Santa Monica Music Center" } }
    
    it "must have a nickname" do 
      missing_nickname = Location.new( valid_attributes.merge(nickname: "") )
      expect(missing_nickname).not_to be_valid
    end
    
  end
  
end
