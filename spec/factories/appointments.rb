FactoryBot.define do
  factory :appointment do
    appointment_time { {"date" => "12/12/2012", "hour" => "09", "min" => "30"} }
    duration { 1 }
    price { 1.5 }
    # location { create(:location) }
    # user 
    # client 
    before(:create) do |app|
      app.client = create(:client)
      app.location = create(:location)
    end
  end
end
