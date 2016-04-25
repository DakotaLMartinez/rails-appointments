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
  let(:tomorrow_at_ten) { DateTime.now.midnight + 34.hours }
  let(:new_client) { user.clients.create(name: 'my new client') }
  let(:new_appointment) { user.appointments.create(appointment_time: { "date" => tomorrow_at_ten.strftime("%Y-%m-%d"), "hour" => (tomorrow_at_ten - 1.hour).strftime("%l"), "min" => tomorrow_at_ten.strftime("%M") }, duration: 3600, price: 80, client: new_client) }
  describe "#appointment_hour" do 
    it "converts an appointment time into the 10 PM format" do 
      expect(appointment_hour(new_appointment)).to eq("9 AM")
    end
  end
  
end
