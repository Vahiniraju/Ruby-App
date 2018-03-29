FactoryBot.define do

  factory :question do
    title  "What color is sky?"
    association :user
    before(:create) do |question|
      if question.answers.length == 0
        3.times do |i|
          question.answers.build(title: "foo#{i+1}", is_correct:(i == 0 ? true: false) )
        end
      end
    end
  end


end