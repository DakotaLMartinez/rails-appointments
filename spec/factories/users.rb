FactoryGirl.define do
  factory :user do
    # confirmed_at Time.now
    email "test@example.com"
    password "please123"
  end
  factory :sandra do 
    email "sandra@sandra.com" 
    password "sandrapass"
  end
  factory :dakota do 
    email "dakota@dakota.com"
    password "dakotapass"
  end
end
