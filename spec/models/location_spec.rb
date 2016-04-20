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
  
end
