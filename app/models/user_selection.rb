class UserSelection < ApplicationRecord
  validates_uniqueness_of :question_id, scope: :user_id
  belongs_to :question
  belongs_to :user
  belongs_to :answer
  validates :question,:answer,:user , presence: true

  before_save :assign_correct_answer

  def assign_correct_answer
    self.correct_answer = self.question.correct_answer == self.answer
  end

end
