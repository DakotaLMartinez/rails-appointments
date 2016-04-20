require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:sandra) { User.find_by(email: "sandra@sandra.com") || User.create(email: "sandra@sandra.com", password: "sandrapass") }
  let(:axel) { Client.find_or_create_by(name: "Axel", phone_number: "(999) 999-9999", email: "axel@gmail.com", user_id: sandra.id) }
  
  context "attributes" do 
    
     it "has a name" do 
      expect(axel.name).to eq("Axel")
    end
    
    it "has a phone number" do 
      expect(axel.phone_number).to eq("(999) 999-9999")
    end
    
    it "has an email address" do 
      expect(axel.email).to eq("axel@gmail.com")
    end
    
  end
  
  context "associations" do 
    
    let(:two_days_later) { DateTime.now.midnight + 59.hours }
    let(:next_week) { DateTime.now.midnight + 14.hours + 7.days }
    
    let(:santa_monica) { Location.find_or_create_by(nickname: "Santa Monica Music", city: "Santa Monica", street_address: "1901 Santa Monica Blvd", state: "CA", zipcode: "90404", business_name: "Santa Monica Music Center") }
    let(:culver_city) { Location.find_or_create_by(nickname: "Culver City Music", city: "Culver City", street_address: "10862 Washington Blvd", state: "CA", zipcode: "90232", business_name: "Culver City Music Center") }
    
    let(:appointment1) { Appointment.create( appointment_time: two_days_later, duration: 3600, price: 80, location_id: santa_monica.id, client_id: axel.id, user_id: sandra.id) }
    let(:appointment2) { Appointment.create( appointment_time: next_week, duration: 5400, price: 110, location_id: culver_city.id, client_id: axel.id, user_id: sandra.id) }
    
    it "belongs to a user" do 
      expect(axel.user).to eq(sandra)
    end

    it "has many appointments" do
      [appointment1, appointment2]
      axel.save
      expect(axel.appointments).to include(appointment1, appointment2)
    end
    
    it "has many locations through appointments" do 
      [appointment1, appointment2]
      axel.save 
      expect(axel.locations).to include(santa_monica, culver_city)
    end
    
  end
  
  context "validations" do 
    
    it "must have a name, but phone number and email are optional" do 
      new_client = Client.new(name: "", user_id: sandra.id)
      expect(new_client).not_to be_valid 
      
      named_client = Client.new(name: "ihave aname", user_id: sandra.id)
      expect(named_client).to be_valid
    end
    
    it "only accepts valid email addresses" do 
      new_client = Client.new(name: "newclient", email: "myemail", user_id: sandra.id)
      expect(new_client).not_to be_valid
      
      valid_client = Client.new(name: "newclient", email: "myemail@gmail.com", user_id: sandra.id)
      expect(valid_client).to be_valid
    end
    
    it "only accepts valid phone numbers" do 
      new_client = Client.new(name: "newclient", phone_number: "111 182 12", user_id: sandra.id)
      expect(new_client).not_to be_valid 
      
      valid_client = Client.new(name: "newclient", phone_number: "(123) 456-7890", user_id: sandra.id)
      expect(valid_client).to be_valid
    end
    
    it "is valid only when associated with an existing user" do 
      new_client = Client.new(name: "newclient", user_id: 99999999999 )
      expect(new_client).not_to be_valid
      
      valid_client = Client.new(name: "newclient", user_id: sandra.id)
      expect(valid_client).to be_valid
      
    end
    
  end
  
end

