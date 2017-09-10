FactoryGirl.define do
  factory :user do
    email "test@blocipedia.com"
    password pwd
    role :admin
  end
end
