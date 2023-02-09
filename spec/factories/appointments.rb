FactoryBot.define do
  factory :appointment do
    appointment_time { {"date" => "12/12/2012", "hour" => "09", "min" => "30"} }
    duration { 1 }
    price { 1.5 }
    location nil
    user nil
    client nil
  end
end
