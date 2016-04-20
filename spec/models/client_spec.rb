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
  
end

