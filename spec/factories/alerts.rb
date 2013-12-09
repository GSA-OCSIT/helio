# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alert do
    alert_type nil
    body "MyText"
    sent_at "2013-12-09 11:09:22"
  end
end
