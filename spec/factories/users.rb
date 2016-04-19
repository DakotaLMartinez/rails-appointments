FactoryGirl.define do
  factory :user do
    # confirmed_at Time.now
    email "test@example.com"
    password "please123"
  end
end
