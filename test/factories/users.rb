FactoryBot.define do

  factory :user do
    sequence(:username)  {|n| "foo#{n}" }
    first_name "jane"
    last_name "doe"
    sequence(:email) {|n|"john#{n}@example.com"}
    password  "Password#1"
    password_confirmation "Password#1"
  end

end