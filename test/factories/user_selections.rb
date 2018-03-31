FactoryBot.define do
  factory :user_selection do
    association :user
    association :question

    before(:create) do |user_selection|
      unless user_selection.answer
        user_selection.answer = user_selection.question.answers.sample
      end
    end

  end
end
