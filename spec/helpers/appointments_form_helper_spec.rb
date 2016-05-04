require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AppointmentsHelper. For example:
#
# describe AppointmentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AppointmentsFormHelper, :devise, type: :helper do
  let(:user) { User.create(email: "my@email.com", password: "mypassword") }
  let(:tomorrow_at_nine) { DateTime.now.midnight + 33.hours }
  let(:new_client) { user.clients.create(name: 'my new client') }
  let(:new_appointment) { user.appointments.create(appointment_time: { "date" => tomorrow_at_nine.strftime("%Y-%m-%d"), "hour" => (tomorrow_at_nine).strftime("%l"), "min" => tomorrow_at_nine.strftime("%M") }, duration: 3600, price: 80, client: new_client) }
  let(:appointment_draft) { user.appointments.build }
  context "helpers to fill in current form field values" do 
     describe "#appointment_date" do 
      it "displays the date of an appointment using the 12/12/2012 format" do 
        expect(appointment_date(new_appointment)).to eq(tomorrow_at_nine.strftime("%m/%d/%Y"))
      end
      it "displays today's date by default" do 
        expect(appointment_date(appointment_draft)).to eq(DateTime.now.strftime("%m/%d/%Y"))
      end
    end
    
    describe "#appointment_hour" do 
      it "displays the hour of the appointment without padding" do 
        expect(appointment_hour(new_appointment)).to eq("9 AM")
      end
      it "displays '8 AM' by default" do 
        expect(appointment_hour(appointment_draft)).to eq("8 AM")
      end
    end
    
    describe "#appointment_min" do 
      it "displays the minute value of the appointment time" do
        new_appointment.appointment_time += 30.minutes
        expect(appointment_min(new_appointment)).to eq("30")
      end
      it "displays 00 by default" do 
        expect(appointment_min(appointment_draft)).to eq("00")
      end
    end
    
    describe "#get_duration_hour" do 
      it "displays the number of seconds in the hour portion of the duration" do 
        expect(get_duration_hour(new_appointment)).to eq(3600)
      end
      it "defaults to 0" do 
        expect(get_duration_hour(appointment_draft)).to eq(0)
      end
    end
    
    describe "#get_duration_min" do 
      it "displays the number of seconds in the minute portion of the duration" do 
        expect(get_duration_min(new_appointment)).to eq(0)
      end
      it "defaults to '1800'" do 
        expect(get_duration_min(appointment_draft)).to eq(1800)
      end
    end
    
  end
  
 
  
end
